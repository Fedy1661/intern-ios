//
//  TableView.swift
//  Cams
//
//  Created by CPRO GROUP on 23.05.2022.
//

import UIKit
import RealmSwift

protocol CellProtocol {
    func fill(_ data: Any)
}

enum Properties: String {
    case name = "name"
    case locked = "locked"
}

enum Tab {
    case cameras
    case doors
}

final class TableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    let fetcher = Fetcher()
    var notificationToken = [NotificationToken]()
    
    struct Row {
        var data: BaseObject
        var identifier: String
    }
    
    var items: [Row] = []
    var currentTypeItems: Tab = .cameras
    
    var tableRefreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        defer { sender.endRefreshing() }
        if currentTypeItems == .cameras {
            fetcher.fetchCameras { result in
                guard let cams = result?.data.cameras else { return }
                cams.forEach { camera in
                    let newCamera = Camera()
                    
                    newCamera.id = camera.id
                    newCamera.name = camera.name
                    newCamera.room = camera.room
                    newCamera.snapshot = camera.snapshot
                    newCamera.favorites = camera.favorites
                    newCamera.rec = camera.rec
                    
                    newCamera.save()
                }
                
                self.content(Camera.getAll())
                sender.attributedTitle = NSAttributedString(string: "Загрузка..")
            }
        } else {
            fetcher.fetchDoors { result in
                guard let doors = result?.getData() else { return }
                
                doors.forEach { door in
                    let newDoor = Door()
                    
                    newDoor.name = door.name
                    newDoor.room = door.room
                    newDoor.favorites = door.favorites
                    newDoor.snapshot = door.snapshot
                    newDoor.id = door.id
                    newDoor.locked = true
                    
                    newDoor.save()
                }
                self.content(Door.getAll())
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        delegate = self
        dataSource = self
        refreshControl = tableRefreshControl
        
        content(Camera.getAll())
    }
    
    func content(_ data: [Object]) {
        if !notificationToken.isEmpty { notificationToken.removeAll() }
        
        items = data.map { item in
            guard let item = item as? BaseObject else { fatalError() }
            
            let indentifier: String = {
                if item is Camera { return CamCell.identifier }
                if let door = item as? Door, door.snapshot != nil {
                    return DoorphoneCell.identifier
                }
                return EntranceCell.identifier
            }()
            
            return .init(
                data: item,
                identifier: indentifier
            )
        }
        
        reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "."
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
        
        if let cell = cell as? CellProtocol { cell.fill(item.data) }
        
        notificationToken.append(item.data.observe({ change in
            self.observe(change: change, cell: cell)
        }))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deselectRow(at: indexPath, animated: true)
        let k = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "second.screen") as! DoorViewController
        guard let item = self.items[indexPath.row].data as? Door else { return }
        
        k.locked = item.locked
        k.callback[.open] = { item.toggleLock() }
        k.callback[.delete] = { item.delete() }
        
        self.window?.rootViewController?.present(k, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cell = self.cellForRow(at: indexPath)
        let toggleFavoriteAction = UIContextualAction(style: .destructive, title:  "", handler: { (_, _, success: (Bool) -> Void) in
            guard let item = self.items[indexPath.row].data as? Favorites else { return }
            guard let cell = cell as? FavoriteCell else { return }
            item.toggleFavorite()
            cell.favorite.isHidden = !cell.favorite.isHidden
            success(true)
        })
        
        let editNameAction = UIContextualAction(style: .destructive, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            guard let item = self.items[indexPath.row].data as? Name else { return }
            self.pushEditNameAlert(item)
            success(true)
        })
        
        toggleFavoriteAction.backgroundColor = UIColor(named: "backgroundColor")
        editNameAction.backgroundColor = UIColor(named: "backgroundColor")
        
        toggleFavoriteAction.image = UIImage(named: "starSwipe")
        editNameAction.image = UIImage(named: "edit")
        
        var actions: [UIContextualAction] = [editNameAction]
        if cell is FavoriteCell { actions.insert(toggleFavoriteAction, at: 0)}
        
        return UISwipeActionsConfiguration(actions: actions)
    }
    
    func observe(change: ObjectChange<ObjectBase>, cell: UITableViewCell) {
        guard let indexPath = indexPath(for: cell) else { return }
        
        switch change {
        case .change(_, let properties):
            guard let property = properties.first else { return }
            
            switch Properties(rawValue: property.name) {
            case .name, .locked:
                self.reloadRows(at: [indexPath], with: .fade)
            default: break
            }
        case .deleted:
            self.items.remove(at: indexPath.row)
            self.deleteRows(at: [indexPath], with: .top)
        case .error(_): return
        }
    }
    
    // MARK: -  Alerts
    
    func pushEditNameAlert(_ item: Name) {
        let alertController = UIAlertController(title: "Изменить название", message: "Введите название", preferredStyle: .alert)
        
        alertController.addTextField { nameField in
            nameField.placeholder = "Введите название"
            nameField.text = item.name
        }
        
        let save = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let name = alertController.textFields?.first?.text else { return }
            item.update(name: name)
        }
        let cancel = UIAlertAction(title: "Отменить", style: .cancel)
        
        alertController.addAction(save)
        alertController.addAction(cancel)
        
        self.window?.rootViewController?.present(alertController, animated: true)
    }
}
