/*
 *  AppModel.swift
 *  MemeMeTwo
 *
 *  Created by Paul Lewallen on 6/4/23.
 *
 */

import UIKit

struct AppModel {
    
    static let fontTableViewSegueIdentifier     = "fontTableView"
    static let fontCellReuseIdentifier          = "fontCell"
    static let fontAvailable                    = UIFont.familyNames
    static var curentFontIndex : Int            = 1
    static var selectedFont : String            = "system"
    static let defaultTopTextFieldText          = "TOP"
    static let defaultBottomTextFieldText       = "BOTTOM"
    
    struct alert {
        static let alertTitle       = "Trash"
        static let alertMessage     = "Are you sure this is trash?"
    }
    
    static let memeTextAttributes : [NSAAttributedString.Key : Any] = []
    
    // TODO: Add stuff
}
