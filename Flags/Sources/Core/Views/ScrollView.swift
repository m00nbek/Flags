//
//  ScrollView.swift
//  Fursat
//
//  Created by NY on 28/07/21.
//

import UIKit

class ScrollView: View {
    let scrollView = NYScrollView()
    
    let scrollContentView = NYView()
    
    let stackView = NYStackView(axis: .vertical, distribution: .fill, alignment: .fill, spacing: 20)
    
    override func setupSubviews() {
        super.setupSubviews()
        
        contentView.addSubview(scrollView)
        
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.addSubview(stackView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            scrollContentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: Padding.l),
            stackView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: Padding.l),
            stackView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -Padding.l),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: scrollContentView.bottomAnchor, constant: -Padding.l)
        ])
    }
}
