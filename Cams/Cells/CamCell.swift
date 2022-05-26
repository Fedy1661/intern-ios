//
//  CamCell.swift
//  Cams
//
//  Created by CPRO GROUP on 25.05.2022.
//

import UIKit

class CamCell: UITableViewCell, CellProtocol {
    static let identifier = "CamCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recording: UIView!
    @IBOutlet weak var favorite: UIImageView!
    @IBOutlet weak var snapshotImage: UIImageView!
    
    func fill(_ data: Any) {
        print(data)
        guard let data = data as? Camera else { return }
        
        titleLabel.text = data.name
        recording.isHidden = !data.rec
        favorite.isHidden = !data.favorites
        guard let url = URL(string: data.snapshot) else { return }
        
        DispatchQueue.global().async {
            let dataImage = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.snapshotImage.image = UIImage(data: dataImage!)
            }
        }
    }
}
