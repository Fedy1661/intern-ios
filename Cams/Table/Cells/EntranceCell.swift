//
//  EntranceCell.swift
//  Cams
//
//  Created by CPRO GROUP on 25.05.2022.
//

import UIKit

class EntranceCell: UITableViewCell, CellProtocol {
    static let identifier = "EntranceCell"
    
    @IBOutlet weak var locked: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func fill(_ data: Any) {
        guard let data = data as? Door else { return }
        
        titleLabel.text = data.name
        locked.isHidden = !data.locked
    }
    
}
