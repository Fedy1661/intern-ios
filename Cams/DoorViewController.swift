//
//  DoorViewController.swift
//  Cams
//
//  Created by Fedor Konovalov on 27.05.2022.
//

import UIKit

enum Action {
    case open, delete
}

class DoorViewController: ViewController {
    
    var locked = Bool()
    var callback: [Action: () -> Void] = [:]
    
    @IBOutlet weak var toggleDoorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggleDoorLabel.text = locked ? "Открыть дверь" : "Закрыть дверь"
    }

    @IBAction func openDoor(_ sender: Any) {
        callback[.open]!()
        dismiss(animated: true)
    }

    @IBAction func deleteDoor(_ sender: Any) {
        callback[.delete]!()
        dismiss(animated: true)
    }
    
}

