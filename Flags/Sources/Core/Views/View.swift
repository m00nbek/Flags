//
//  View.swift
//  Fursat
//
//  Created by NY on 27/07/21.
//

import UIKit


public protocol ViewInstaller {
    func setupSubviews()
    
    func setupConstraints()
    
    func setupTargets()
    
    func style()
    
    func localize()
}

public extension ViewInstaller {
    func setup() {
        setupSubviews()
        setupConstraints()
        setupTargets()
        localize()
        style()
    }
}

open class View: UIView, ViewInstaller {
    let contentView = NYView()
    
    var contentViewBottom: NSLayoutConstraint!
    
    open func setupSubviews() {
        addSubview(contentView)
    }
    
    open func setupConstraints() {
        contentViewBottom = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentViewBottom,
        ])
    }
    
    open func setupTargets() {
        
    }
    
    open func style() {
        backgroundColor = .white
    }
    
    open func localize() {
        
    }
    
    public init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
