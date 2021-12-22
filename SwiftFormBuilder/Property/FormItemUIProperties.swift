//
//  FormItemUIProperties.swift
//  SwiftFormBuilder
//
//  Created by Alessandro Marcon on 12/05/2021.
//

import Foundation
import UIKit

/// UIKit properties for ViewModels
public class FormItemUIProperties {
    
    //MARK: - Properties
    /// Element tint color
    private var tintColor = UIColor.white
    /// Color to hightlight message and field in case of error
    private var errorColor: UIColor = .red
    /// Keyboard type in case of textfield
    private var keyboardType = UIKeyboardType.default
    /// Cell type to load
    private var cellType: FormItemCellType?
    /// Custom font
    private var font: UIFont?
    /// Custom font size, if we'd like to customize only 
    private var fontSize: CGFloat?
    /// Text color
    private var textColor: UIColor = .white
    /// Text for underlined color
    private var underlineColor: UIColor = .blue
    /// Text alignment
    private var textAlignment: NSTextAlignment?
    /// Color for non text element background
    private var nonTextualElementColor: UIColor = .white
    /// Textfield UI properties
    private var textFieldProperty: FormItemTextFieldProperty?
    /// Button UI properties
    private var buttonProperty: FormItemButtonProperty?
    
    
    //MARK: - Init
    public init(itemType: FormItemCellType) {
        self.cellType = itemType
    }
    
    //MARK: - Getter and Setter
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func tintColor(_ value: UIColor) -> FormItemUIProperties {
        self.tintColor = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getTintColor() -> UIColor {
        return self.tintColor
    }
    
    /// Color of error elements
    /// - Parameter value: UIColor to use in case of error to highlight error elements
    /// - Returns:
    public func errorColor(_ value: UIColor) -> FormItemUIProperties {
        self.errorColor = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getErrorColor() -> UIColor {
        return self.errorColor
    }
    
    /// Set keyboard type to show when textfield being active. Default keyboard will shown if keyboard type wasn't setted up.
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func keyboardType(_ value: UIKeyboardType) -> FormItemUIProperties {
        self.keyboardType = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getKeyboardType() -> UIKeyboardType {
        return self.keyboardType
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getCellType() -> FormItemCellType? {
        return self.cellType
    }
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func font(_ value: UIFont) -> FormItemUIProperties {
        self.font = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getFont() -> UIFont? {
        return self.font
    }
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func fontSize(_ value: CGFloat) -> FormItemUIProperties {
        self.fontSize = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getFontSize() -> CGFloat? {
        return self.fontSize
    }
    
    /// Set text color. Default color is white
    /// - Parameter value: UIColor object
    /// - Returns:
    public func textColor(_ value: UIColor) -> FormItemUIProperties {
        self.textColor = value
        return self
    }
    
    /// Get current text color
    /// - Returns: UIColor object
    func getTextColor() -> UIColor {
        return self.textColor
    }
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func underlinedColor(_ value: UIColor) -> FormItemUIProperties {
        self.underlineColor = value
        return self
    }
    
    /// Get current underlined text color
    /// - Returns: UIColor object
    func getUnderlinedTextColor() -> UIColor {
        return self.underlineColor
    }
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func alignment(_ value: NSTextAlignment) -> FormItemUIProperties {
        self.textAlignment = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getAlignment() -> NSTextAlignment? {
        return self.textAlignment
    }
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func textFieldPropertie(_ value: FormItemTextFieldProperty) -> FormItemUIProperties {
        self.textFieldProperty = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getTextfieldProperty() -> FormItemTextFieldProperty? {
        return self.textFieldProperty
    }
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func buttonPropertie(_ value: FormItemButtonProperty) -> FormItemUIProperties {
        self.buttonProperty = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getButtonProperty() -> FormItemButtonProperty? {
        return self.buttonProperty
    }
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func elementColor(_ value: UIColor) -> FormItemUIProperties {
        self.nonTextualElementColor = value
        return self
    }
    
    /// Get current underlined text color
    /// - Returns: UIColor object
    func getNonTextualElementBackgroundColor() -> UIColor {
        return self.nonTextualElementColor
    }
}
