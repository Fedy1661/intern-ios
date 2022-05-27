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
    
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var signifier: UIView!
    
    @IBOutlet weak var tableView: TableView!
    @IBOutlet weak var signifierLeading: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Camera.getAll().isEmpty {
            fetcher.fetchCameras { [self] result in
                guard let cams = result?.getData() else { return }
                Camera.save(cams)

                tableView.content(Camera.getAll())

            }
        }

        if Door.getAll().isEmpty {
            fetcher.fetchDoors { result in
                guard let doors = result?.getData() else { return }

                Door.save(doors)
            }
        }
    }

    @IBAction func didTapCameras(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        let vc = storyboard.instantiateViewController(withIdentifier: "DoorViewController")
//        present(vc, animated: true)
        self.signifierLeading.constant = 0
        
        tableView.content(Camera.getAll())
    }
    
    @IBAction func didTapDoors(_ sender: Any) {
        self.signifierLeading.constant = self.signifier.frame.width

        tableView.content(Door.getAll())
    }
    
}
