//
//  ViewController.swift
//  Fursat
//
//  Created by NY on 21/07/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTargets()
        
//        if navigationController?.viewControllers.count == 1 {
//            let item = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(showMenu))
//            navigationItem.leftBarButtonItem = item
//        }
    }
    
    private func setupTargets() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(animateIfNeeded), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ViewController {
    @objc public func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc public func keyboardWillShow(notification: NSNotification) {
        guard let _view = view as? View else {return}
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            var height: CGFloat = (self.tabBarController?.tabBar.isHidden ?? true) ? 0 : self.tabBarController?.tabBar.frame.height ?? 0
            
            height += self.view.safeAreaInsets.bottom
            
            _view.contentViewBottom.constant = -(keyboardSize.height - height)
            _view.setNeedsLayout()
            UIView.animate(withDuration: 0.2) {
                _view.layoutIfNeeded()
            }
        }
    }
    
    @objc public func keyboardWillHide(notification: NSNotification) {
        guard let _view = view as? View else {return}
        
        _view.contentViewBottom.constant = 0
        _view.setNeedsLayout()
    }
    
    @objc public func animateIfNeeded() {
        guard let _view = view as? View else {return}
        UIView.animate(withDuration: 0.2) {
            _view.layoutIfNeeded()
        }
    }
}
