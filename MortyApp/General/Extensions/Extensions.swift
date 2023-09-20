//
//  Extensions.swift
//  MortyApp
//
//  Created by Eduardo Marquez on 19/09/23.
//

import UIKit
import SDWebImage

// MARK: - UIViewController
extension UIViewController {
    enum ButtonDirections {
        case leftButton
        case rightButton
    }
    
    func setNav(icon: UIImage?, to button: ButtonDirections, target: Any?, action: Selector?, color: UIColor = .white, font: UIFont? = nil, and title: String = "", speacing addSpacing: Double = 0) {
        
        let barButton = UIBarButtonItem(image: icon, style: .plain, target: target, action: action)
        
        switch button {
        case .leftButton:
            navigationItem.leftBarButtonItem = barButton
            navigationItem.leftBarButtonItem?.tintColor = color
            navigationItem.leftBarButtonItem?.title = title
            
            
            
            if let font = font {
                navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: font, .foregroundColor: color], for: .normal)
                navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: font, .foregroundColor: color], for: .highlighted)
                navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: font, .foregroundColor: color], for: .selected)
            }
            
            navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.kern: addSpacing], for: .normal)
            navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.kern: addSpacing], for: .highlighted)
            navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.kern: addSpacing], for: .selected)
            break
        default:
            navigationItem.rightBarButtonItem = barButton
            navigationItem.rightBarButtonItem?.tintColor = color
            navigationItem.rightBarButtonItem?.title = title
            if let font = font {
                navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: font, .foregroundColor: color], for: .normal)
                navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: font, .foregroundColor: color], for: .highlighted)
                navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: font, .foregroundColor: color], for: .selected)
            }
            
            navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.kern: addSpacing], for: .normal)
            navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.kern: addSpacing], for: .highlighted)
            navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.kern: addSpacing], for: .selected)
            break
        }
        

    }
    
    func setCustomNav(customView: UIView, to button: ButtonDirections) {
        let barButton = UIBarButtonItem(customView: customView)
        
        switch button {
        case .leftButton:
            navigationItem.leftBarButtonItem = barButton
            break
        default:
            navigationItem.rightBarButtonItem = barButton
        }
    }
    
    func showOptionsAlert(title: String?, redButtonTitle: String, message: String, cancelBlock: @escaping() -> Void) {
        let refreshAlert = UIAlertController(
            title: title ?? "",
            message: message,
            preferredStyle: .alert
        )
        
        refreshAlert.addAction(UIAlertAction(title: redButtonTitle, style: .destructive, handler: { _ in
            cancelBlock()
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
}

extension UITextField{
    func setPlaceHolderColor() {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray,
//                                                                                                NSAttributedString.Key.font: setFont(of: .semibold, family: .Sans, and: 12)  TODO
                                                                                               ])
    }
}

extension UIImageView {
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
}

import Foundation

@objc public protocol Then {}
extension Then {

    /// Makes it available to set properties with closures just after initializing.
    ///
    ///     let label = UILabel().then {
    ///         $0.textAlignment = .Center
    ///         $0.textColor = UIColor.blackColor()
    ///         $0.text = "Hello, World!"
    ///     }
    @discardableResult
    public func then(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }

}

extension NSObject: Then {}

