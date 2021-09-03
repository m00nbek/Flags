//
//  NYTableView.swift
//  Fursat
//
//  Created by NY on 14/08/21.
//

import UIKit.UITableView

class NYTableView: UITableView {
    
    convenience init(style: UITableView.Style = .grouped) {
        self.init(frame: .zero, style: style)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
