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
        setupData()
    }
    
    // MARK: - Setup
    
    func setupData() {
        if Camera.getAll().isEmpty {
            fetcher.fetchCameras { [self] result in
                guard let cams = result?.getData() else { return }
                cams.forEach { Camera.insert($0) }
                tableView.content(Camera.getAll())
            }
        }

        if Door.getAll().isEmpty {
            fetcher.fetchDoors { result in
                guard let doors = result?.getData() else { return }
                doors.forEach { Door.insert($0)}
            }
        }
    }
    
    // MARK: - Actions

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
