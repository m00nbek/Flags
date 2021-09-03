//
//  NYDivider.swift
//  Fursat
//
//  Created by NY on 29/07/21.
//

import UIKit

class NYDivider: NYView {
    let divider = NYView()
    
    var paddingX: CGFloat = 0
    
    var paddingY: CGFloat = 0
    
    init(color: UIColor = UIColor.black.withAlphaComponent(0.7), paddingX: CGFloat = 0, paddingY: CGFloat = 0) {
        super.init()
        
        divider.backgroundColor = color
        
        self.paddingX = paddingX
        self.paddingY = paddingY
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 100, height: 0.5)
    }
    
    private func setup() {
        addSubview(divider)
        
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: topAnchor, constant: paddingY),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: paddingX),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -paddingX),
            divider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -paddingY),
        ])
    }
}
