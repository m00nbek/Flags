//
//  AppPreferencePanes.swift
//  Fursat
//
//  Created by NY on 27/07/21.
//

import Foundation


class AppPreferencePanes {
    static let shared = AppPreferencePanes()
    
    var lang: String {
        get {
            UserDefaults.standard.string(forKey: "lang") ?? "ru"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "lang")
        }
    }
    
    private init() {
        
    }
}
