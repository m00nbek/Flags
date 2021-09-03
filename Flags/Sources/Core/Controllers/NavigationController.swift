//
//  NavigationController.swift
//  Fursat
//
//  Created by NY on 22/07/21.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationBar.prefersLargeTitles = false
        
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.darkGray]
        
        navigationBar.barTintColor = UIColor.white
        navigationBar.tintColor = .darkGray
        
        navigationBar.isTranslucent = false
        navigationBar.isOpaque = true
        
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
}
