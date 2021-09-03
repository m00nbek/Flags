//
//  NYImageVIew.swift
//  Fursat
//
//  Created by NY on 29/07/21.
//

import UIKit.UIImageView

open class NYImageView: UIImageView {
    
    public init(image: UIImage? = nil, tintColor: UIColor? = nil, cornerRadius: CGFloat = 0, contentMode: ContentMode = .center) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        clipsToBounds = true
        self.contentMode = contentMode
        
        if let color = tintColor {
            self.image = image?.withRenderingMode(.alwaysTemplate)
            self.tintColor = color
        } else {
            self.image = image
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
