//
//  EntranceCell.swift
//  Cams
//
//  Created by CPRO GROUP on 25.05.2022.
//

import UIKit

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
