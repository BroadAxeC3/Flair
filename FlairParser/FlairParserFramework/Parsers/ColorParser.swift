//
//  ColorParser.swift
//  FlairParser
//
//  Created by Jerry Mayers on 7/25/16.
//  Copyright © 2016 Mobelux. All rights reserved.
//

import Foundation
import Flair

enum ColorParser {
    private enum Constants {
        static let colorsKey = "colors"
    }
    
    static func parse(json: JSON) throws -> [NamedColorSet] {
        guard let colorDict = json[Constants.colorsKey] as? JSON else { throw Parser.ParserError.missingColorDict }
    
        var colors: [NamedColorSet] = []
        colors.reserveCapacity(colorDict.count)
        
        for colorKey in colorDict.keys {
            if let colorValueDict = colorDict[colorKey] as? JSON {
                let namedColorSet = try NamedColorSet(name: colorKey, colorValues: colorValueDict)
                colors.append(namedColorSet)
            }
        }
        
        return colors
    }
}
