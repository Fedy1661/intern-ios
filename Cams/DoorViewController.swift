//
//  DoorViewController.swift
//  Cams
//
//  Created by Fedor Konovalov on 27.05.2022.
//

import UIKit

class DoorViewController: ViewController {

    @IBOutlet weak var openDoorView: UIView!
    @IBOutlet var gestureOpenDoor: UITapGestureRecognizer!
    
    var callback: (() -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func openDoor(_ sender: Any) {
        callback()
        dismiss(animated: true)
    }

}

