//
//  NYLabel.swift
//  Fursat
//
//  Created by NY on 29/07/21.
//

import UIKit

open class NYLabel: UILabel {
    
    open var topInset: CGFloat = 5.0
    open var bottomInset: CGFloat = 5.0
    open var leftInset: CGFloat = 7.0
    open var rightInset: CGFloat = 7.0
    
    open override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    open override var bounds: CGRect {
        didSet {
            // Supported Multiple Lines in Stack views
            // preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
    
    public init(_ text: String = "NYLabel",
                font: UIFont? = nil,
                textColor: UIColor = .systemGray,
                textAlignment: NSTextAlignment = .left,
                numberOfLines: Int = 1,
                backgroundColor: UIColor = .clear,
                insets: UIEdgeInsets = UIEdgeInsets.zero) {
        
        super.init(frame: .zero)
        
        topInset = insets.top
        leftInset = insets.left
        rightInset = insets.right
        bottomInset = insets.bottom
        
        self.text = text
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
        if let font = font {
            self.font = font
        }
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
