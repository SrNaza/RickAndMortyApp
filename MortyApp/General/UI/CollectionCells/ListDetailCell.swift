//
//  ListDetailCell.swift
//  MortyApp
//
//  Created by Nazareth Villalba on 19/09/23.
//

import UIKit
import SDWebImage

class ListDetailCell: UICollectionViewCell {

    @IBOutlet weak var vista: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setupComponent()
    }

    func setupComponent() {
        vista.layer.cornerRadius = 20
        vista.layer.masksToBounds = true
        nameLabel.textColor = .black
        nameLabel.text = ""
        speciesLabel.textColor = .black
        speciesLabel.text = ""
    }
    
    func setupCell(item: Character) {
        nameLabel.text = item.name
        speciesLabel.text = String("Species: \(item.species)")
        
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
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
