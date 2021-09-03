//
//  NYActivityIndicatorView.swift
//  Fursat
//
//  Created by NY on 02/08/21.
//

import UIKit

open class NYActivityIndicatorView: UIActivityIndicatorView {
    public init (color: UIColor = .systemBlue, style: UIActivityIndicatorView.Style = .whiteLarge) {
        super.init(frame: .zero)
        
        self.hidesWhenStopped = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.style = style
        self.color = color
    }
    
    required public init(coder: NSCoder) {
        fatalError()
    }
}
