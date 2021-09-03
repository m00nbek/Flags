
import Foundation

public class FirstnameRule : RegexRule {
    
    static let regex = "^[a-zA-Z]+(\\.)?(\\s+[a-zA-Z]+(\\.)?)*$"
    
    public convenience init(message : String = "Must be word") {
        self.init(regex: FirstnameRule.regex, message : message)
    }
}
