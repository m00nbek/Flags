//
//  NYScrollView.swift
//  Fursat
//
//  Created by NY on 29/07/21.
//

import UIKit

open class NYScrollView: UIScrollView {
    
    public init() {
        super.init(frame: .zero)
        
        alwaysBounceVertical = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
    }
    
    required public init?(coder: NSCoder) {
        fatalError()
    }
}

