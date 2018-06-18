//
//  ShopAisleCell.swift
//  KitchenWares
//
//  Created by vic on 17/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import UIKit

class ShopAisleCell: UICollectionViewCell {
    static let id = "ShopAisleCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var borderView: UIView!
    private var identifier: String?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        borderView.layer.borderColor = UIColor(white: 0.9, alpha: 1.0).cgColor
        borderView.layer.borderWidth = 1
    }
    
    func update(title: String, price: String, identifier: String) {
        titleLabel.text = title
        priceLabel.text = price
        self.identifier = identifier
    }
    
    func cellIdentifer() -> String? {
        return self.identifier
    }
    
    func setImage(image: UIImage) {
        self.image.contentMode = .scaleAspectFit
        self.image.image = image
    }
}
