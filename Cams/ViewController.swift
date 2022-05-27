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
        
        if realm.objects(Camera.self).isEmpty {
            fetcher.fetchCameras { result in
                guard let cams = result?.data.cameras else { return }
                Database.shared.save(cams)
                
                self.tableView.content(Camera.self)
                
            }
        } else {
            self.tableView.content(Camera.self)
        }
        
        if realm.objects(Door.self).isEmpty {
            fetcher.fetchDoors { result in
                guard let doors = result?.data else { return }
                
                Database.shared.save(doors)
            }
        }
    }

    @IBAction func didTapCameras(_ sender: Any) {
        self.signifierLeading.constant = 0
        
        tableView.content(Camera.self)
    }
    
    @IBAction func didTapDoors(_ sender: Any) {
        self.signifierLeading.constant = self.signifier.frame.width

        tableView.content(Door.self)
    }
    
}
