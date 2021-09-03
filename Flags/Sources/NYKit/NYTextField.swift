//
//  NYTextField.swift
//  Fursat
//
//  Created by NY on 01/08/21.
//


import UIKit

public enum TextFieldType: Int {
    case number
    case expires
    case cvv
    case ccNumber
    case name
    case firstName
    case lastName
    case passportID
    case sex
    case birthday
    case dateOfIssue
    case dateOfExpiry
    case money
    case phone
    case sms
    case text
    case date
    case select
    case password
    
    public var keyboard: UIKeyboardType {
        switch self {
        case .ccNumber, .cvv, .number, .dateOfExpiry, .dateOfIssue, .expires, .phone, .sms, .date:
            return .numberPad
        case .money:
            return .decimalPad
        default:
            return .default
        }
    }
}

open class NYTextField: UITextField {
    public var padding: UIEdgeInsets!
    
    open var type: TextFieldType = .name {
        didSet {
            keyboardType = type.keyboard
            tag = type.rawValue
        }
    }
    
    public var amount: Double = 0
    
    
    
    public var selectedValueId = -1
    
    public var selectedValueTitle: String? {
        didSet {
            text = selectedValueTitle
        }
    }
    
    public init(type: TextFieldType = .text, padding: UIEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)) {
        super.init(frame: .zero)
        
        self.padding = padding
        self.type = type
        
        keyboardType = type.keyboard
        tag = type.rawValue
        
        self.addTarget(self, action: #selector(textDidChange(_:)), for: .allEditingEvents)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}

extension NYTextField {
    @objc public func textDidChange(_ textField: NYTextField) {
        switch textField.type {
        case .phone:
            textField.text = textField.text?.phoneFormat(with: "+XXX XX XXX XX XX")
        case .sms:
            textField.text = textField.text?.phoneFormat(with: "XXXXX")
        case .ccNumber:
            textField.text = textField.text?.phoneFormat(with: "XXXX XXXX XXXX XXXX")
            
        case .dateOfExpiry:
            textField.text = textField.text?.phoneFormat(with: "XX/XX")
            
        case .date:
            textField.text = textField.text?.phoneFormat(with: "XX/XX/XXXX")
            
        case .money:
            guard let text = textField.text else {return}
            
            textField.attributedText = text.moneyFormatted(fractionSize: textField.minimumFontSize)
        default:
            break
        }
    }
}

//extension NYTextField: Validatable {
//
//    open var validationText: String {
//        return text ?? ""
//    }
//}

extension String {
    public func htmlString() -> NSMutableAttributedString? {
        let htmlData = NSString(string: self).data(using: String.Encoding.unicode.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
                        NSAttributedString.DocumentType.html]
        
        return try? NSMutableAttributedString(data: htmlData ?? Data(),
                                              options: options,
                                              documentAttributes: nil)
    }
    
    /// mask example: `+X (XXX) XXX-XXXX`
    public func phoneFormat(prefix: String? = nil, with mask: String) -> String {
        var _self = self
        if let prefix = prefix?.trimmingCharacters(in: .whitespaces), _self.hasPrefix(prefix) {
            _self.removeSubrange(_self.startIndex..<_self.index(_self.startIndex, offsetBy: prefix.count))
        }
        let numbers = _self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        var result = ""
        var index = numbers.startIndex // numbers iterator
        
        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])
                
                // move numbers iterator to the next index
                index = numbers.index(after: index)
                
            } else {
                result.append(ch) // just append a mask character
            }
        }
        
        if let prefix = prefix {
            result = prefix + result
        }
        
        return result
    }
    
    public func cardFormatted() -> String {
        self.separate(every: 4, with: " ")
    }
    
    public func separate(every stride: Int = 4, with separator: Character = " ") -> String {
        return String(enumerated().map { $0 > 0 && $0 % stride == 0 ? [separator, $1] : [$1]}.joined())
    }
    
    public func removeAllSpaces() -> String {
        String(self.filter{ !" ".contains($0)})
    }
    
    public func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    /// 12342.34 -> 12 342.34
    public func moneyFormatted(fractionSize: CGFloat = 17) -> NSAttributedString {
        var text = self.removeAllSpaces()
        
        if text == "00" {
            text.removeLast()
        }
        
        var dollar, cent: String?
        var addDot = false
        
        text = text.money
        text = text.replacingOccurrences(of: ",", with: ".")
        if text.contains(".") {
            if text.hasPrefix(".") {
                text = "0\(text)"
            }
            let split = text.split(separator: ".")
            if split.count > 1 {
                dollar = String(split[0])
                cent = String(split[1])
            } else {
                addDot = true
                text.removeLast()
                dollar = text
            }
        } else {
            dollar = text
        }
        
        var attributedString = NSMutableAttributedString(string: "")
        
        if var dollar = dollar {
            if dollar.count > 1 && dollar.hasPrefix("0") {
                dollar.removeFirst()
            }
            if dollar.count > 12 {
                dollar.removeLast()
            }
            let reversedDollar = String(dollar.reversed())
            let withSpace = reversedDollar.separate(every: 3, with: " ")
            text = String(withSpace.reversed())
            
            attributedString = NSMutableAttributedString(string: text)
        }
        
        if var cent = cent {
            if cent.count > 2 {
                let index = cent.index(cent.startIndex, offsetBy: 2)
                cent = String(cent[..<index])
            }
            
            let attrCent = NSAttributedString(string: cent, attributes: [.font: UIFont.systemFont(ofSize: fractionSize, weight: .regular)])
            
            attributedString.append(NSAttributedString(string: "."))
            attributedString.append(attrCent)
        } else if addDot {
            attributedString.append(NSAttributedString(string: "."))
        }
        
        return attributedString
    }
}

extension StringProtocol where Self: RangeReplaceableCollection {
    public var digits: Self { filter (\.isWholeNumber) }
    
    public var money: Self { filter { (c) -> Bool in
        c.isNumber || c == "." || c == ","
    }}
}
