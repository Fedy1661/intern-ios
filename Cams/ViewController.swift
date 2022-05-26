//
//  ViewController.swift
//  Cams
//
//  Created by Fedor Konovalov on 22.05.2022.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    let fetcher = Fetcher()
    let realm = try! Realm()
    
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var signifier: UIView!
    
    @IBOutlet weak var tableView: TableView!
    @IBOutlet weak var signifierLeading: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.content()
        render()
//        print(realm.objects(Door.self))
        // Do any additional setup after loading the view.
    }
    
    func render() {
        print("_____RENDER_____")
        let doors = realm.objects(Door.self)
        for door in doors {
            print(door.name)
        }
    }

    @IBAction func didTapCameras(_ sender: Any) {
        self.signifierLeading.constant = 0
        
        tableView.items.removeAll()
        tableView.search = true
        tableView.content()
    }
    
    @IBAction func didTapDoors(_ sender: Any) {
        self.signifierLeading.constant = self.signifier.frame.width

        fetcher.fetchDoors {[weak self] result in
            guard let self = self else { return }
            
            self.tableView.items.removeAll()
            self.tableView.sections = ["."]
            result?.getData().forEach({ door in
                var newItem: TableView.Row
                if let snapshot = door.snapshot {
                    newItem = .init(
                        data: DoorphoneCell.Model(
                            title: door.name,
                            subTitle: door.room,
                            favorite: door.favorites,
                            snapshot: snapshot
                        ),
                        identifier: DoorphoneCell.identifier
                    )
                } else {
                    newItem = .init(
                        data: EntranceCell.Model(
                            title: door.name
                        ),
                        identifier: EntranceCell.identifier
                    )
                }
                self.tableView.items.append(newItem)
            })
            self.tableView.search = false
            self.tableView.sectionHeaderTopPadding = 20
            self.tableView.reloadData()
        }
    }
    
}
