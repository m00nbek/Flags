//
//  KeyValView.swift
//  Fursat
//
//  Created by NY on 22/08/21.
//

import UIKit

class KeyValView: NYView {
    let keyLabel = NYLabel("key", font: .systemFont(ofSize: 16, weight: .regular), textColor: Color.lightTextColor, numberOfLines: 0)
    
    let valLabel = NYLabel("val", font: .systemFont(ofSize: 16, weight: .regular), textColor: Color.darkTextColor, numberOfLines: 0)
    
    convenience init(key: String, val: String, valColor: UIColor) {
        self.init()
        
        keyLabel.text = key
        valLabel.text = val
        valLabel.textColor = valColor
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(keyLabel)
        addSubview(valLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        keyLabel.setContentHuggingPriority(.required, for: .horizontal)
        keyLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate([
            keyLabel.topAnchor.constraint(equalTo: topAnchor),
            keyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            keyLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            
            valLabel.topAnchor.constraint(equalTo: topAnchor),
            valLabel.leadingAnchor.constraint(equalTo: keyLabel.trailingAnchor, constant: Padding.s),
            valLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            valLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
