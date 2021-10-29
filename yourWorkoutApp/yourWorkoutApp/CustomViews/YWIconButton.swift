//
//  YWIconButton.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 28.10.2021.
//

import UIKit

class YWIconButton: UIButton {

    private var systemNameImage: String = "xmark"
    private var normalColor: UIColor = .iconNormalColor
    private var highLightedColor: UIColor = .iconHighlightColor
    
    private let borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = nil
        return layer
    }()
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.05) { [self] in
                imageView?.tintColor = isHighlighted ?  highLightedColor: normalColor
                borderLayer.strokeColor = isHighlighted ?  highLightedColor.cgColor : normalColor.cgColor
                borderLayer.lineWidth = isHighlighted ?  2 : 2
            }
        }
    }
    
    
    convenience init(systemNameImage: String) {
        self.init(frame: .zero)
        self.systemNameImage = systemNameImage
        setupAppearance()
    }
    
    convenience init(systemNameImage: String, normalColor: UIColor, highLightedColor: UIColor) {
        self.init(frame: .zero)
        self.systemNameImage = systemNameImage
        self.normalColor = normalColor
        self.highLightedColor = highLightedColor
        imageView?.tintColor = isHighlighted ?  highLightedColor: normalColor
        setupAppearance()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
    
}

extension YWIconButton {
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        borderLayer.strokeColor = normalColor.cgColor
//        borderLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.width / 2).cgPath
//        borderLayer.lineWidth = 2
//        layer.cornerRadius = bounds.width / 2
//    }
}

private extension YWIconButton {
    func setupAppearance() {
        layer.addSublayer(borderLayer)
        tintColor = normalColor
        setImage(UIImage(systemName: systemNameImage)?.withTintColor(normalColor), for: .normal)
        setImage(UIImage(systemName: systemNameImage)?.withTintColor(highLightedColor), for: .highlighted)
    }
}
