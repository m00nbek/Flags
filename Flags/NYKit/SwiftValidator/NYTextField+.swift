
import UIKit

extension NYTextField: Validatable {

    open var validationText: String {
        return text ?? ""
    }
}

extension UITextView: Validatable {

    public var validationText: String {
        return text ?? ""
    }
}
