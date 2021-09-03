//
//  FormRow.swift
//  Fursat
//
//  Created by NY on 01/08/21.
//

import UIKit

class FormRow: NYView {
    weak var validator: Validator? {
        didSet {
            guard let validator = validator else {return}
            validator.registerField(field, errorLabel: errorLabel, rules: rules)
        }
    }
    
    weak var validationDelegate: ValidationDelegate?
    
    private let stackView = NYStackView(axis: .vertical, distribution: .fill, alignment: .fill, spacing: Padding.s)
    
    var rules: [Rule] = []
    
    let titleLabel = NYLabel("Title", font: UIFont.systemFont(ofSize: 14, weight: .medium), textColor: Color.blackColor, numberOfLines: 3)
    
    let errorLabel = NYLabel("Error", font: UIFont.systemFont(ofSize: 14, weight: .regular), textColor: UIColor.red, numberOfLines: 3)
    
    let field = NYTextField(type: .text, padding: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
    
    convenience init(title: String, placeholder: String, type: TextFieldType = .text, validator: Validator? = nil, validationDelegate: ValidationDelegate? = nil, rules: [Rule] = []) {
        self.init()
        
        titleLabel.text = title
        field.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .regular)])
        field.type = type
        if type == .password {
            self.field.autocapitalizationType = .none
            self.field.autocorrectionType = .no
            self.field.textContentType = .password
            self.field.isSecureTextEntry = true
        }
        self.validator = validator
        self.validationDelegate = validationDelegate
        self.rules = rules
        
        if let validator = validator {
            validator.registerField(field, errorLabel: errorLabel, rules: rules)
        }
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(field)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func setupTargets() {
        super.setupTargets()
        
        field.addTarget(self, action: #selector(validateForm), for: .editingDidEnd)
    }
    
    override func style() {
        super.style()
        
        field.backgroundColor = Color.inputBackground
        field.layer.cornerRadius = 10
        field.clipsToBounds = true
        
        field.layer.borderWidth = 1
        field.layer.borderColor = Color.inputBorder.cgColor
    }
    
    override func localize() {
        super.localize()
        
        field.placeholder = "Placeholder"
    }
    
    @objc public func validateForm() {
        guard let delegate = validationDelegate, let validator = validator else {return}
        
        validator.validateField(field) { error in
            if let error = error {
                stackView.addArrangedSubview(errorLabel)
                errorLabel.text = error.errorMessage
            } else {
                errorLabel.removeFromSuperview()
            }
            
            validator.validate(delegate)
        }
    }
}
