//
//  NamedColorSet+Init.swift
//  FlairParser
//
//  Created by Jerry Mayers on 7/25/16.
//  Copyright © 2016 Mobelux. All rights reserved.
//

import Foundation
import Flair

extension NamedColorSet {
    private enum Constants {
        static let normalColorKey = "normal"
        static let highlightedColorKey = "highlighted"
        static let selectedColorKey = "selected"
        static let disabledColorKey = "disabled"
    }
    
    init(name: String, colorValues: JSON) throws {
        self.name = name
        
        guard let normalValue = colorValues[Constants.normalColorKey] as? String else { throw Parser.ParserError.missingStandardColor }
        normalColor = try Color(string: normalValue)
        
        if let highlightedValue = colorValues[Constants.highlightedColorKey] as? String {
            highlightedColor = try Color(string: highlightedValue)
        } else {
            highlightedColor = nil
        }
        
        if let selectedValue = colorValues[Constants.selectedColorKey] as? String {
            selectedColor = try Color(string: selectedValue)
        } else {
            selectedColor = nil
        }
        
        if let disabledValue = colorValues[Constants.disabledColorKey] as? String {
            disabledColor = try Color(string: disabledValue)
        } else {
            disabledColor = nil
        }
    }
}
