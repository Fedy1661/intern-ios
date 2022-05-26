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
    static let identifier = "CamCell"
    
    struct Model {
        let title: String
        let recording: Bool
        let favorite: Bool
        let snapshot: String
        let room: String?
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var recording: UIView!
    @IBOutlet private weak var favorite: UIImageView!
    @IBOutlet private weak var snapshotImage: UIImageView!
    
    func fill(_ data: Any) {
        guard let data = data as? Model else { return }
        
        titleLabel.text = data.title
        recording.isHidden = !data.recording
        favorite.isHidden = !data.favorite
        guard let imageURL = URL(string: data.snapshot) else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.snapshotImage.image = image
            }
        }
    }
}

class DoorphoneCell: UITableViewCell, CellProtocol {
    static let identifier = "DoorphoneCell"
    
    struct Model {
        let title: String
        let subTitle: String
        let favorite: Bool
        let snapshot: String?
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var lock: UIImageView!
    @IBOutlet weak var favorite: UIImageView!
    @IBOutlet weak var snapshotImage: UIImageView!
    
    func fill(_ data: Any) {
        guard let data = data as? Model else { return }
        
        titleLabel.text = data.title
        subTitleLabel.text = data.subTitle
        favorite.isHidden = !data.favorite
        
        guard let snaphot = data.snapshot else { return }
        guard let imageURL = URL(string: snaphot) else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.snapshotImage.image = image
            }
        }
    }
}

class EntranceCell: UITableViewCell, CellProtocol {
    static let identifier = "EntranceCell"
    
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
    let fetcher = Fetcher()
    
    struct Row {
        var data: Any
        var identifier: String
        //        var response: Response = .o
    }
    
    var items: [Row] = []
    var sections: [String] = []
    
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
            guard let result = result else { return }
            
            result.data.cameras.forEach { [weak self] camera in
                self?.items.append(
                    .init(
                        data: CamCell.Model(
                            title: camera.name,
                            recording: camera.rec,
                            favorite: camera.favorites,
                            snapshot: camera.snapshot,
                            room: camera.room
                        ),
                        identifier: CamCell.identifier)
                )
            }
            self.sections = result.data.room
            
            self.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.filter { item in
            guard let camCell = item.data as? CamCell.Model else { return false }

            return camCell.room == sections[section]
        }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        print(indexPath.section)
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
        if let ptc = cell as? CellProtocol {
            ptc.fill(item.data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("numberOfSections")
        return sections.count
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
