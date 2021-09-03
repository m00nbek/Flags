//
//  UIDevice.swift
//  Fursat
//
//  Created by NY on 01/08/21.
//

import UIKit

public func isDevice(_ device: UIUserInterfaceIdiom) -> Bool {
    UIDevice.current.userInterfaceIdiom == device
}
