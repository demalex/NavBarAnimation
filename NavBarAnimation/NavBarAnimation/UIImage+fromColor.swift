//
//  UIImage+fromColor.swift
//  NavBarAnimation
//
//  Created by Tomasz Pietrowski on 16/01/2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func fromColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        defer {
            UIGraphicsEndImageContext()
        }
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            assertionFailure("Couldn't get image from current image context.")
            return UIImage()
        }
        return image
    }
}
