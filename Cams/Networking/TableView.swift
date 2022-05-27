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

final class TableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    let realm = Realm.app
    let fetcher = Fetcher()
    
    struct Row {
        var data: Any
        var identifier: String
    }
    
    var items: [Row] = []
//    var callbacks
    
    var myRefreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        fetcher.fetchCameras { result in
            guard let cams = result?.data.cameras else { return }
            Camera.save(cams)
            
            self.content(Camera.getAll())
            
            sender.endRefreshing()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        delegate = self
        dataSource = self
        
        refreshControl = myRefreshControl
    }
    
    
    func content(_ data: [Object]) {
        items = data.map { item in
            guard let item = item as? BaseObject else { fatalError() }
            let indentifier:String = {
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
        if let ptc = cell as? CellProtocol {
            ptc.fill(item.data)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addToFavoritesAction = UIContextualAction(style: .destructive, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
            guard let item = self.items[indexPath.row].data as? Favorites else { return }
            item.toggleFavorite()
            self.content(Camera.getAll())
        })
        let editAction = UIContextualAction(style: .destructive, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
            
            let alertController = UIAlertController(title: "Изменить название", message: "Введите название", preferredStyle: .alert)
            self.reloadData()
            let save = UIAlertAction(title: "Сохранить", style: .default) { _ in
                if let name = alertController.textFields?.first?.text {
                    guard let item = self.items[indexPath.row].data as? Name else { return }
                    item.updateName(name)
                    self.reloadData()
                }
            }
            let cancel = UIAlertAction(title: "Отмнить", style: .cancel, handler: nil)
            
            alertController.addTextField { nameField in
                guard let item = self.items[indexPath.row].data as? Name else { return }
                nameField.placeholder = "Введите название"
                nameField.text = item.name
            }
            
            alertController.addAction(save)
            alertController.addAction(cancel)
            
            self.window?.rootViewController?.present(alertController, animated: true)
        })
        
        let addToFavoritesActionImage = UIImage(named: "starSwipe")
        let editActionImage = UIImage(named: "edit")
        
        addToFavoritesAction.backgroundColor = UIColor(named: "backgroundColor")
        editAction.backgroundColor = UIColor(named: "backgroundColor")
        
        addToFavoritesAction.image = addToFavoritesActionImage
        editAction.image = editActionImage
        return UISwipeActionsConfiguration(actions: [addToFavoritesAction, editAction])
    }
}
