//
//  TableView.swift
//  Cams
//
//  Created by CPRO GROUP on 23.05.2022.
//

import UIKit

protocol CellProtocol {
    func fill(_ data: Any)
}

class TableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    let fetcher = Fetcher()
    
    struct Row {
        var data: Any
        var identifier: String
        
    }
    
    var items: [Row] = []
    var sections: [String?] = []
    var search = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        delegate = self
        dataSource = self
    }
    
    func content() {
        fetcher.fetchCameras { result in
            guard let data = result?.data else { return }
            
            data.cameras.forEach({ cam in
                self.items.append(
                    .init(
                        data: cam, identifier: CamCell.identifier
                    )
                )
            })
            self.sections = data.room
            self.sections.append(nil)
            
            self.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if search {
            return items.filter { item in
                guard let itemData = item.data as? Camera else { return false }

                return itemData.room == sections[section]
            }.count
        } else {
            return items.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section]
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .destructive, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
        })
        let editAction = UIContextualAction(style: .destructive, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
        })
        let deleteActionImage = UIImage(named: "starSwipe")
        let editActionImage = UIImage(named: "edit")
        
        deleteAction.backgroundColor = UIColor(named: "backgroundColor")
        editAction.backgroundColor = UIColor(named: "backgroundColor")
        
        deleteAction.image = deleteActionImage
        editAction.image = editActionImage
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}
