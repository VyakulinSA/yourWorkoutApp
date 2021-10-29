//
//  UIFont + extension.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 28.10.2021.
//

import Foundation
import UIKit

enum CustomFont: String {
    case myFontBold = "Montserrat-Bold"
    case myFontRegular = "Montserrat-Regular"
    case myFontSemiBold = "Montserrat-SemiBold"
}

extension UIFont {
    
    static func myFont(_ customFont: CustomFont, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: customFont.rawValue, size: size) else {
            return UIFont.systemFont(ofSize: 14, weight: .semibold)
        }
        return font
    }
    
}
