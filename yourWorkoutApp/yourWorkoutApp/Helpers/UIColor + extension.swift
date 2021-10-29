//
//  UIColor + extension.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 28.10.2021.
//

import Foundation
import UIKit
import SwiftUI
 
extension UIColor {
    
    static var inputViewsColor: UIColor {
        return UIColor(named: "inputViewsColor") ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    static var mainBackgroundColor: UIColor {
        return UIColor(named: "mainBackgroundColor") ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    static var normalButtonColor: UIColor {
        return UIColor(named: "normalButtonColor") ?? #colorLiteral(red: 0.1568627451, green: 0.2980392157, blue: 0.4941176471, alpha: 1)
    }
    
    static var outlineColor: UIColor {
        return UIColor(named: "outlineColor") ?? #colorLiteral(red: 0.3607843137, green: 0.5921568627, blue: 0.5764705882, alpha: 1)
    }
    
    static var selectedBadgeColor: UIColor {
        return UIColor(named: "inputViewsColor") ?? #colorLiteral(red: 0.3607843137, green: 0.5921568627, blue: 0.5764705882, alpha: 1)
    }
    
    static var unselectedBadgeColor: UIColor {
        return UIColor(named: "unselectedBadgeColor") ?? #colorLiteral(red: 0.8823529412, green: 0.9215686275, blue: 0.9019607843, alpha: 1)
    }
    
    static var darkTextColor: UIColor {
        return UIColor(named: "darkTextColor") ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    static var labelTextColor: UIColor {
        return UIColor(named: "labelTextColor") ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    static var lightTextColor: UIColor {
        return UIColor(named: "lightTextColor") ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    static var iconHighlightColor: UIColor {
        return UIColor(named: "iconHighlightColor") ?? #colorLiteral(red: 0.3607843137, green: 0.5921568627, blue: 0.5764705882, alpha: 1)
    }
    
    static var iconNormalColor: UIColor {
        return UIColor(named: "iconNormalColor") ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
