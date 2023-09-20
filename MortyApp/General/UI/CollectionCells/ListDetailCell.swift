//
//  ListDetailCell.swift
//  MortyApp
//
//  Created by Eduardo Marquez on 19/09/23.
//

import UIKit
import SDWebImage

class ListDetailCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setupComponent()
    }

    func setupComponent() {
//        nameLabel.font = setFont(of: .semibold, family: .Sans, and: 12) todo nz
        nameLabel.textColor = .black
        
//        typeLabel.font = setFont(of: .bold, family: .Sans, and: 15)
        speciesLabel.textColor = .black
        
        
        nameLabel.text = ""
        speciesLabel.text = ""
    }
    
    func setupCell(item: Character) {
        nameLabel.text = item.name
        speciesLabel.text = String("Species: \(item.species)")
           
//        shippingLabel.text = item.shipping.freeShipping ? "Envio Gratis" : item.condition
//        shippingLabel.textColor = item.shipping.freeShipping ? .red : .black
        
        imageView.contentMode = .scaleAspectFit
        donwloadImage(imageView: self.imageView, urlString: item.image)
    }
}

func donwloadImage(imageView: UIImageView, urlString: String) {
    guard let url = URL(string: urlString) else {
        imageView.image = Images.image(type: .placeholderImage)
        return
    }
    
    imageView.sd_setImage(with: url, placeholderImage: Images.image(type: .placeholderImage), completed: { (image, error, cacheType, imageUrl) in
        if error == nil {
            imageView.image = image
        } else {
            imageView.image = Images.image(type: .placeholderImage)
        }
    })
}
