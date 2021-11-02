//
//  YWIconButton.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 28.10.2021.
//

import UIKit
import SwiftUI

enum IconButtonNames: String{
    case plus = "plus"
    case burger = "text.justifyleft"
    case backArrow = "arrow.left"
    case gear = "gear"
    case filter = "slider.horizontal.3"
    case error = "xmark.app"
    case circlePlus = "plus.circle"
    case checkmarkSeal = "checkmark.seal"
}

class YWIconButton: UIButton {
 
    private var normalColor: UIColor = .iconNormalColor
    private var highLightedColor: UIColor = .iconHighlightColor
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.05) { [self] in
                imageView?.tintColor = isHighlighted ?  highLightedColor: normalColor
            }
        }
    }
    
    convenience init(systemNameImage: IconButtonNames?) {
        self.init(frame: .zero)
        setupAppearance(systemNameImage: systemNameImage)
    }
    
    convenience init(systemNameImage: IconButtonNames?, normalColor: UIColor, highLightedColor: UIColor) {
        self.init(frame: .zero)
        self.normalColor = normalColor
        self.highLightedColor = highLightedColor
        imageView?.tintColor = isHighlighted ?  highLightedColor: normalColor
        setupAppearance(systemNameImage: systemNameImage)
    }

    
}

extension YWIconButton {
    func setupAppearance(systemNameImage: IconButtonNames?) {
        guard let systemNameImage = systemNameImage else {return}
        let systemImageName = systemNameImage.rawValue
        tintColor = normalColor
        setImage(UIImage(systemName: systemImageName)?.withTintColor(normalColor), for: .normal)
        setImage(UIImage(systemName: systemImageName)?.withTintColor(highLightedColor), for: .highlighted)
    }
}
