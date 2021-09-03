//
//  NYView.swift
//  Fursat
//
//  Created by NY on 28/07/21.
//

import UIKit


open class NYView: UIView {
    open func setupSubviews() {
        
    }
    
    open func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    open func setupTargets() {
        
    }
    
    open func style() {
        
    }
    
    open func localize() {
        
    }
    
    private func setup(){
        setupSubviews()
        setupConstraints()
        setupTargets()
        style()
        localize()
    }
    
    public init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
