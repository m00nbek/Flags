//
//  Extensions.swift
//  Fursat
//
//  Created by NY on 27/07/21.
//

import UIKit

public extension UIView {
    class var uid: String {
        String(describing: self)
    }
}

extension UIColor {
    convenience init(hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            self.init()
        } else {
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: CGFloat(1.0))
        }
    }
}


private class BundleFinder {}

extension Foundation.Bundle {
    /// Returns the resource bundle associated with the current Swift module.
    static var moduleBundle: Bundle = {
        let bundleName = "Fursat_Fursat"
        
        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,
            
            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: BundleFinder.self).resourceURL,
            
            // For command-line tools.
            Bundle.main.bundleURL,
        ]
        
        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        
        return Bundle.main
    }()
}


extension String {
    public var localized: String {
        let primaryDict = localization(for: AppPreferencePanes.shared.lang)
        
        if let str = primaryDict[self] {
            return str
        } else if let str = fallbackDict[self] {
            return str
        }
        
        return self
    }
    
    public func dateComponentsFrom(format: String = "dd/MM/yyyy") -> DateComponents? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            
            return components
        }
        
        return nil
    }
    
    public func apiDateFormat() -> String {
        guard let components = self.dateComponentsFrom(),
              let d = components.day,
              let M = components.month,
              let year = components.year else {
            return self
        }
        
        let day = d < 10 ? "0\(d)" : "\(d)"
        let month = M < 10 ? "0\(M)" : "\(M)"
        
        return "\(year)-\(month)-\(day)"
    }
}

func localization(for lang: String) -> [String: String] {
    guard let mainPath = Bundle.moduleBundle.path(forResource: lang, ofType: "lproj"), let bundle = Bundle(path: mainPath) else {
        return [:]
    }
    guard let path = bundle.path(forResource: "Localizable", ofType: "strings") else {
        return [:]
    }
    guard let dict = NSDictionary(contentsOf: URL(fileURLWithPath: path)) as? [String: String] else {
        return [:]
    }
    return dict
}

let fallbackDict: [String: String] = localization(for: "en")

extension UIViewController {
    public func loadChild(_ viewController: UIViewController, onView: UIView? = nil) {
        let view: UIView = onView ?? self.view
        
        // `willMoveToParentViewController:` is called automatically when adding
        
        addChild(viewController)
        
        viewController.view.frame = view.bounds
        viewController.view.translatesAutoresizingMaskIntoConstraints = true
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(viewController.view)
        
        viewController.didMove(toParent: self)
    }
    
    public func unloadChild(_ viewController: UIViewController?) {
        guard let viewController = viewController else {
            return
        }
        
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
        // `didMoveToParentViewController:` is called automatically when removing
    }
    
    public func presentAlert(title: String?, message: String?, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK".localized, style: .cancel, handler: handler)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}
