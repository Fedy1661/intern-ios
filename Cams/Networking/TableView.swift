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

class CamCell: UITableViewCell, CellProtocol {
    struct Model {
        let title: String
        let recording: Bool
        let favorite: Bool
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recording: UIView!
    @IBOutlet weak var favorite: UIImageView!
    
    func fill(_ data: Any) {
        print("Hhh")
        guard let data = data as? Model else { return }
        
        print(data)
        titleLabel.text = data.title
        recording.isHidden = !data.recording
        favorite.isHidden = !data.favorite
    }
}

class DoorphoneCell: UITableViewCell, CellProtocol {
    struct Model {
        let title: String
        let subTitle: String
        let favorite: Bool
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var lock: UIImageView!
    @IBOutlet weak var favorite: UIImageView!
    
    func fill(_ data: Any) {
        guard let data = data as? Model else { return }
        
        titleLabel.text = data.title
        subTitleLabel.text = data.subTitle
        favorite.isHidden = !data.favorite
    }
}

class EntranceCell: UITableViewCell, CellProtocol {
    struct Model {
        let title: String
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func fill(_ data: Any) {
        guard let data = data as? Model else { return }
        
        titleLabel.text = data.title
    }
    
}

class TableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    struct Row {
        var data: Any
        var identifier: String
//        var response: Response = .o
    }
    
    var items: [Row] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        delegate = self
        dataSource = self
     }
    
    func content() {
        items = [

            .init(data: CamCell.Model(title: "Cam With Favorite", recording: false, favorite: true), identifier: "CamCell"),
            .init(data: CamCell.Model(title: "Cam With Rec", recording: true, favorite: false), identifier: "CamCell"),
            .init(data: DoorphoneCell.Model(title: "Doorphone", subTitle: "Sub", favorite: true), identifier: "DoorphoneCell"),
            .init(data: EntranceCell.Model(title: "Door 1"), identifier: "EntranceCell"),
            .init(data: EntranceCell.Model(title: "Door 2"), identifier: "EntranceCell"),
            .init(data: EntranceCell.Model(title: "Door 3"), identifier: "EntranceCell"),
            .init(data: EntranceCell.Model(title: "Door 4"), identifier: "EntranceCell"),
            .init(data: EntranceCell.Model(title: "Door 5"), identifier: "EntranceCell"),
            .init(data: EntranceCell.Model(title: "Door 6"), identifier: "EntranceCell"),
            .init(data: EntranceCell.Model(title: "Door 7"), identifier: "EntranceCell"),
            

        ]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
        if let ptc = cell as? CellProtocol {
            ptc.fill(item.data)
            ptc.fill(item.data)
        }
        print(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Гостиная"
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Add") { (action, view, handler) in
            print("Add Action Tapped")
        }
        deleteAction.backgroundColor = .green
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .destructive, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            //whatever
            success(true)
        })
        let editAction = UIContextualAction(style: .destructive, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            //whatever
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
