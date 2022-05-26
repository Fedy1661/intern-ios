//
//  DoorphoneCell.swift
//  Cams
//
//  Created by CPRO GROUP on 25.05.2022.
//

import UIKit

class DoorphoneCell: UITableViewCell, CellProtocol {
    static let identifier = "DoorphoneCell"
    
    struct Model {
        let title: String
        let subTitle: String?
        let favorite: Bool
        let snapshot: String
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var lock: UIImageView!
    @IBOutlet weak var favorite: UIImageView!
    @IBOutlet weak var snapshotImage: UIImageView!
    
    func fill(_ data: Any) {
        guard let data = data as? Model else { return }
        
        titleLabel.text = data.title
        subTitleLabel.text = data.subTitle
        favorite.isHidden = !data.favorite
        guard let url = URL(string: data.snapshot) else { return }
        
        DispatchQueue.global().async {
            let dataImage = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.snapshotImage.image = UIImage(data: dataImage!)
            }
        }
    }
}
