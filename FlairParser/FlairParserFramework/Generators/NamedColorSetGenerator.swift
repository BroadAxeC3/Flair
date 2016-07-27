//
//  NamedColorSetGenerator.swift
//  FlairParser
//
//  Created by Jerry Mayers on 7/26/16.
//  Copyright © 2016 Mobelux. All rights reserved.
//

import Foundation
import Flair

enum NamedColorSetGenerator {
    private enum Constants {
        static let normal = "normal"
        static let highlighted = "highlighted"
        static let selected = "selected"
        static let disabled = "disabled"
    }
    
    static func generate(colors: [NamedColorSet], headerComment: String) -> String {
        var swiftCode = "\(headerComment)\n\nimport Flair\n\nextension ColorSet {\n"
        
        let sortedColors = colors.sorted { $0.name < $1.name }
        for color in sortedColors {
            let colorFunc = generate(color: color)
            swiftCode.append(colorFunc)
        }
        
        swiftCode.append("}\n")
        return swiftCode
    }
    
    private static func generate(color: NamedColorSet) -> String {
        let normal = generate(color: color.normalColor, name: Constants.normal)!
        let highlighted = generate(color: color.highlightedColor, name: Constants.highlighted)
        let selected = generate(color: color.selectedColor, name: Constants.selected)
        let disabled = generate(color: color.disabledColor, name: Constants.disabled)
        
        var returnLine = "        return ColorSet(normalColor: \(Constants.normal)"
        if highlighted != nil {
            returnLine.append(", highlightedColor: \(Constants.highlighted)")
        }
        if selected != nil {
            returnLine.append(", selectedColor: \(Constants.selected)")
        }
        if disabled != nil {
            returnLine.append(", disabledColor: \(Constants.disabled)")
        }
        returnLine.append(")\n")
        
        var colorFunc = "    static func \(color.name)() -> ColorSet {\n"
        colorFunc.append(normal)
        if let highlighted = highlighted {
            colorFunc.append(highlighted)
        }
        if let selected = selected {
            colorFunc.append(selected)
        }
        if let disabled = disabled {
            colorFunc.append(disabled)
        }
        
        colorFunc.append(returnLine)
        colorFunc.append("    }\n\n")
        return colorFunc
    }
    
    private static func generate(color: Color?, name: String) -> String? {
        guard let color = color else { return nil }
        
        let colorString = "        let \(name) = Color(red: \(color.red), green: \(color.green), blue: \(color.blue), alpha: \(color.alpha))\n"
        return colorString
    }
}
