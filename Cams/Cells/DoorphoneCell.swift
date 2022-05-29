//
//  DoorphoneCell.swift
//  Cams
//
//  Created by CPRO GROUP on 25.05.2022.
//

import UIKit

class DoorphoneCell: UITableViewCell, CellProtocol {
    static let identifier = "DoorphoneCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var lock: UIImageView!
    @IBOutlet weak var favorite: UIImageView!
    @IBOutlet weak var snapshotImage: UIImageView!
    @IBOutlet weak var locked: UIImageView!
    
    func fill(_ data: Any) {
        guard let data = data as? Door else { return }
        print(data)
        titleLabel.text = data.name
        subTitleLabel.text = data.room
        favorite.isHidden = !data.favorites
        locked.isHidden = !data.locked
        
        guard let url = URL(string: data.snapshot ?? "") else { return }
        
        Service.loadImage(url: url) { [weak self] dataImage in
            guard let self = self else { return }
            
            self.snapshotImage.image = UIImage(data: dataImage)
        }
    }
}
