//
//  NamedStyle.swift
//  FlairParser
//
//  Created by Jerry Mayers on 7/25/16.
//  Copyright © 2016 Mobelux. All rights reserved.
//

import Foundation
import Flair

/// A `StyleType` that has a name you can set
public struct NamedStyle: StyleType {
    public let name: String
    
    public let font: Font
    public let kerning: CGFloat
    public let lineSpacing: CGFloat
    public let textColor: NamedColorSet?
    
    /**
     Primary initializer to use when creating a `NamedStyle`
     
     - parameter name:            A name to use for this style
     - parameter font:            The `Font` to use for this style
     - parameter kerning:         Any kerning that should be applied. A value of 0 disables kerning
     - parameter lineSpacing:     Any line spacing that should be applied. A value of 0 disables line spacing. Values < 0 are invalid and will be clamped to 0.
     - parameter textColor:       The `ColorSet` to use for the text color
     
     - returns: A valid `Style`
     */
    public init(name: String, font: Font, kerning: CGFloat = 0, lineSpacing: CGFloat = 0, textColor: NamedColorSet? = nil) {
        self.name = name
        self.font = font
        self.kerning = kerning
        // Make sure that the value is >= 0, don't save negitive values
        self.lineSpacing = lineSpacing >= 0 ? lineSpacing : 0
        self.textColor = textColor
    }
}
