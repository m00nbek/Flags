//
//  NYButton.swift
//  Fursat
//
//  Created by NY on 02/08/21.
//

import UIKit


public typealias BoolCompletion = (Bool) -> Void

open class NYButton: UIButton {
    public let activityIndicator = NYActivityIndicatorView(color: .systemBlue, style: .white)
    
    public let gradient = CAGradientLayer()
    
    public var isCircle: Bool = false
    
    public var action: ((_ completion: @escaping BoolCompletion) -> Void)?
    
    public var isLoading: Bool = false {
        didSet {
            if isLoading {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
            
            let alpha: CGFloat = isLoading ? 0 : 1
            titleLabel?.alpha = alpha
            imageView?.alpha = alpha
        }
    }
    
    public var customBackgroundColor: UIColor?
    
    public var customTintColor: UIColor
    
    public var isDisabled = false
    
    public init(title: String? = nil,
                image: UIImage? = nil,
                isCircle: Bool = false,
                isEnabled: Bool = true,
                tintColor: UIColor = .white,
                backgroundColor: UIColor? = nil,
                font: UIFont? = nil) {
        
        customBackgroundColor = backgroundColor
        customTintColor = tintColor
        
        super.init(frame: .zero)
        
        self.isDisabled = !isEnabled
        self.isEnabled = isEnabled
        self.isCircle = isCircle
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(tintColor, for: .normal)
        self.setTitleColor(tintColor.withAlphaComponent(0.3), for: .disabled)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let image = image?.withRenderingMode(.alwaysTemplate) {
            self.setImage(image, for: .normal)
            
            self.tintColor = tintColor
        }
        
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        if let _ = title, let _ = image {
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        }
        
        if let font = font {
            self.titleLabel?.font = font
        }
        
        layout()
        
        addTarget(self, action: #selector(handleAction), for: .primaryActionTriggered)
    }
    
    required public init?(coder: NSCoder) {
        fatalError()
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        gradient.frame = rect
        
        if isCircle {
            layer.cornerRadius = rect.width / 2
            gradient.cornerRadius = rect.width / 2
        } else {
            layer.cornerRadius = 8
            gradient.cornerRadius = 8
        }
        
        layer.masksToBounds = false
        clipsToBounds = true
    }
    
    open override var isHighlighted: Bool {
        didSet {
            
            if oldValue == false && isHighlighted {
                highlight()
            } else {
                unHighlight()
            }
            
        }
    }
    
    open override var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor = customBackgroundColor
            } else {
                let color: UIColor
                if customBackgroundColor == UIColor.clear {
                    color = .clear
                } else {
                    color = customBackgroundColor?.withAlphaComponent(0.3) ?? .systemGray
                }
                backgroundColor = color
            }
        }
    }
    
    func layout() {
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func highlight() {
        alpha = 0.7
    }
    
    func unHighlight() {
        alpha = 1
    }
    
    public func addGradient() {
        //        let colorTop = UIColor.hexColor("FFFFFF").withAlphaComponent(0.3).cgColor
        //        let colorBottom = UIColor.hexColor("FFFFFF").withAlphaComponent(0.01).cgColor
        //
        //
        //        gradient.colors = [colorTop, colorBottom]
        //        gradient.locations = [0.0, 1.0]
        //        gradient.cornerRadius = layer.cornerRadius
        //        gradient.backgroundColor = UIColor.clear.cgColor
        //
        //        layer.insertSublayer(gradient, at: 0)
    }
    
    @objc func handleAction() {
        isLoading = true
        isEnabled = false
        let start = CFAbsoluteTimeGetCurrent()
        action? { [weak self] isEnabled in
            guard let self = self else {return}
            
            self.isLoading = false
            self.isEnabled = self.isDisabled ? isEnabled : true
            
            let finish = CFAbsoluteTimeGetCurrent()
            let time = finish - start
            print("NYButton action time: \(time)")
        }
    }
}

extension NYButton {
    static func systemButton(title: String? = nil, image: UIImage? = nil, tintColor: UIColor = .white, backgroundColor: UIColor? = .darkGray, cornerRadius: CGFloat = 10, font: UIFont? = nil, horizontalAlignment: UIControl.ContentHorizontalAlignment = .center) -> UIButton {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = cornerRadius
        btn.backgroundColor = backgroundColor
        btn.tintColor = tintColor
        btn.setTitle(title, for: .normal)
        btn.setImage(image, for: .normal)
        if let font = font {
            btn.titleLabel?.font = font
        }
        
        btn.contentHorizontalAlignment = horizontalAlignment
        if image != nil {
            btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        }
        
        return btn
    }
}

