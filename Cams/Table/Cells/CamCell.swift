//
//  CamCell.swift
//  Cams
//
//  Created by CPRO GROUP on 25.05.2022.
//

import UIKit

protocol FavoriteCell {
    var favorite: UIImageView! { get set }
}

class CamCell: UITableViewCell, CellProtocol, FavoriteCell {
    static let identifier = "CamCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recording: UIView!
    @IBOutlet weak var favorite: UIImageView!
    @IBOutlet weak var snapshotImage: UIImageView!
    
    func fill(_ data: Any) {
        guard let data = data as? Camera else { return }
        
        titleLabel.text = data.name
        recording.isHidden = !data.rec
        favorite.isHidden = !data.favorites
        guard let url = URL(string: data.snapshot) else { return }
        
        Service.loadImage(url: url) { [weak self] dataImage in
            guard let self = self else { return }
            
            self.snapshotImage.image = UIImage(data: dataImage)
        }
    }
}
