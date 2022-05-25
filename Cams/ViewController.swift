//
//  ViewController.swift
//  Cams
//
//  Created by Fedor Konovalov on 22.05.2022.
//

import UIKit

class ViewController: UIViewController {
    let fetcher = Fetcher()
    
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var signifier: UIView!
    
    @IBOutlet weak var tableView: TableView!
    @IBOutlet weak var signifierLeading: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.content()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapCameras(_ sender: Any) {
        self.signifierLeading.constant = 0
    }
    
    @IBAction func didTapDoors(_ sender: Any) {
        self.signifierLeading.constant = self.signifier.frame.width
        fetcher.fetchDoors { doors in
            guard let doors = doors else { return }
            
            self.tableView.items.removeAll()
            doors.data.forEach({ door in
                print(door)
                self.tableView.items.append(.init(data: EntranceCell.Model(title: door.name), identifier: "EntranceCell"))
                self.tableView.items.append(.init(data: DoorphoneCell.Model(title: door.name, subTitle: door.name, favorite: door.favorites), identifier: "DoorphoneCell"))
            })
            
            self.tableView.reloadData()
        }
    }
    
}
