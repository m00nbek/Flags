//
//  NYStackView.swift
//  Fursat
//
//  Created by NY on 29/07/21.
//

import UIKit

open class NYStackView: UIStackView {
    
    public init(axis: NSLayoutConstraint.Axis,
                distribution: UIStackView.Distribution = .fill,
                alignment: UIStackView.Alignment = .fill,
                spacing: CGFloat = 8) {
        
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
