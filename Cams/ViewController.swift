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
    var setupped: Bool = false
    
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var signifier: UIView!
    
    @IBOutlet weak var tableView: TableView!
    @IBOutlet weak var signifierLeading: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    func setupData() {
        if Camera.getAll().isEmpty {
            fetcher.fetchCameras { [self] result in
                
                guard let cams = result?.getData() else { return }
                
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

                tableView.content(Camera.getAll())
            }
        }

        if Door.getAll().isEmpty {
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
            }
        }
    }

    @IBAction func didTapCameras(_ sender: Any) {
        guard tableView.currentTypeItems != .cameras else { return }
        self.signifierLeading.constant = 0
        
        tableView.currentTypeItems = .cameras
        tableView.content(Camera.getAll())
    }
    
    @IBAction func didTapDoors(_ sender: Any) {
        guard tableView.currentTypeItems != .doors else { return }
        self.signifierLeading.constant = self.signifier.frame.width

        tableView.currentTypeItems = .doors
        tableView.content(Door.getAll())
    }
    
}
