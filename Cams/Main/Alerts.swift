//
//  Alerts.swift
//  Cams
//
//  Created by CPRO GROUP on 30.05.2022.
//

import UIKit

struct Alerts {
    static func pushEditNameAlert(vc: UIViewController, _ item: Name) {
        let alertController = UIAlertController(title: "Изменить название", message: "Введите название", preferredStyle: .alert)
        
        alertController.addTextField { nameField in
            nameField.placeholder = "Введите название"
            nameField.text = item.name
        }
        
        let save = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let name = alertController.textFields?.first?.text else { return }
            item.update(name: name)
        }
        let cancel = UIAlertAction(title: "Отменить", style: .cancel)
        
        alertController.addAction(save)
        alertController.addAction(cancel)
        
        vc.present(alertController, animated: true)
    }
}
