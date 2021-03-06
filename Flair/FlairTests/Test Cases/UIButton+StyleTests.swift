//
//  UIButton+StyleTests.swift
//  Flair
//
//  MIT License
//
//  Copyright (c) 2017 Mobelux
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import XCTest
import Flair

class UIButton_StyleTests: XCTestCase {

    func testStyleTitleColorSet() {
        let red = Color(color: UIColor.red)!
        let green = Color(color: UIColor.green)!
        let blue = Color(color: UIColor.blue)!
        let redFaded = Color(color: UIColor.red.withAlphaComponent(0.25))!

        let colorSet = ColorSet(normalColor: red, highlightedColor: green, selectedColor: blue, disabledColor: redFaded)
        let font = Font(systemFontWeight: .medium, sizeType: .staticSize(pointSize: 14))
        let style = Style(font: font, textColor: colorSet)

        let button = UIButton(type: .custom)
        button.style = style
        XCTAssert(button.titleColorSet() == colorSet, "Color set doesn't match")
        XCTAssert(button.titleColor(for: .normal) == red.color, "Normal color doesn't match")
        XCTAssert(button.titleColor(for: .highlighted) == green.color, "Highlighted color doesn't match")
        XCTAssert(button.titleColor(for: .selected) == blue.color, "Selected color doesn't match")
        XCTAssert(button.titleColor(for: .disabled) == redFaded.color, "Disabled color doesn't match")
    }
    
    func testBasicStyle() {
        let font = Font(systemFontWeight: .medium, sizeType: .staticSize(pointSize: 14))
        let color = Color(red: 0, green: 1, blue: 0, alpha: 1)
        let colorSet = ColorSet(normalColor: color)
        let style = Style(font: font, textColor: colorSet)

        let initialNormalText = "Normal"
        let initialHighlightedText = "Highlighted"
        let initialSelectedText = "Selected"
        let initialDisabledText = "Disabled"

        let button = UIButton(type: .system)
        button.setTitle(initialNormalText, for: .normal)
        button.setTitle(initialHighlightedText, for: .highlighted)
        button.setTitle(initialSelectedText, for: .selected)
        button.setTitle(initialDisabledText, for: .disabled)

        button.style = style

        XCTAssert(button.style == style, "The style we just set doesn't match the style it has now")
        XCTAssert(button.titleLabel?.font == font.font, "The font doesn't match")
    }

    func testAdvancedStyle() {
        let font = Font(systemFontWeight: .medium, sizeType: .staticSize(pointSize: 14))
        let color = Color(red: 0, green: 1, blue: 0, alpha: 1)
        let colorSet = ColorSet(normalColor: color)
        let style = Style(font: font, kerning: 2, lineHeightMultiple: 2.6, textColor: colorSet)

        let initialNormalText = "Normal"
        let initialHighlightedText = "Highlighted"
        let initialSelectedText = "Selected"
        let initialDisabledText = "Disabled"

        let button = UIButton(type: .system)
        button.setTitle(initialNormalText, for: .normal)
        button.setTitle(initialHighlightedText, for: .highlighted)
        button.setTitle(initialSelectedText, for: .selected)
        button.setTitle(initialDisabledText, for: .disabled)

        button.style = style

        XCTAssert(button.style == style, "The style we just set doesn't match the style it has now")

        let alignment = button.titleLabel?.textAlignment ?? .center
        let lineBreakMode = button.titleLabel?.lineBreakMode ?? .byTruncatingMiddle
        let attributes = style.textAttributes(alignment: alignment, lineBreakMode: lineBreakMode)

        let expectedNormalText = NSAttributedString(string: initialNormalText, attributes: attributes)
        XCTAssert(expectedNormalText == button.attributedTitle(for: .normal), "The normal text doesn't match")

        let expectedHighlightedText = NSAttributedString(string: initialHighlightedText, attributes: attributes)
        XCTAssert(expectedHighlightedText == button.attributedTitle(for: .highlighted), "The highlighted text doesn't match")

        let expectedSelectedText = NSAttributedString(string: initialSelectedText, attributes: attributes)
        XCTAssert(expectedSelectedText == button.attributedTitle(for: .selected), "The selected text doesn't match")

        let expectedDisabledText = NSAttributedString(string: initialDisabledText, attributes: attributes)
        XCTAssert(expectedDisabledText == button.attributedTitle(for: .disabled), "The disabled text doesn't match")
    }}
