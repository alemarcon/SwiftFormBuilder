//
//  TextFieldProperty.swift
//  VTRFormBuilder
//
//  Created by Alessandro Marcon on 26/05/2021.
//

import Foundation
import UIKit

/// Left padding values
public enum LeftPadding {
    /// No left space
    case none
    /// Minimun left space of 3 px
    case minimum
    /// Standard left space of 10 px
    case standard
    /// Large left space of 20 px
    case large
    /// Wide left space of 35 px
    case wide
    /// Custom left space size. If bigger than half textfield width, half textfield width will be setted
    case custom(padding: CGFloat)
    
    var floatValue: CGFloat {
        switch self {
        case .none:
            return .zero
        case .minimum:
            return CGFloat(3)
        case .standard:
            return CGFloat(10)
        case .large:
            return CGFloat(20)
        case .wide:
            return CGFloat(35)
        case .custom(let padding):
            return padding
        }
    }
}

/// Textfield border width default values
public enum BorderWidth {
    /// No border
    case none
    /// Thin border of 1 px
    case thin
    /// Standard border of 3 px
    case standard
    /// Large border of 5 px
    case large
    /// Custom border size.
    case custom(padding: CGFloat)
    
    var floatValue: CGFloat {
        switch self {
        case .none:
            return .zero
        case .thin:
            return CGFloat(1)
        case .standard:
            return CGFloat(3)
        case .large:
            return CGFloat(5)
        case .custom(let padding):
            return padding
        }
    }
}

/// Contains all properties to configure UI of textfields
public class FormItemTextFieldProperty {
    
    //MARK: - Properties
    /// Textfield background color. Default color is clear
    private var backgroundColor: UIColor = .clear
    /// Textfield right icon
    private var rightIcon: UIImage?
    /// Make field active or not
    private var isActive: Bool?
    /// The textfield border color. If not setted, a black border color will be returned
    private var borderColor: UIColor = .black
    /// Textfield border with
    private var borderWidth: BorderWidth = .none
    /// The textfield border radius. If zero or negative border radius will not be applied
    private var cornerRadius: CGFloat = .zero
    /// The textfield placeholder color. If not setted, a black color will be returned
    private var placeholderColor: UIColor? = UIColor.VetryaColor.lightGrey
    /// Empty space on the left side of textfield
    private var leftPaggind: LeftPadding = .minimum
    
    /// Default initializer
    public init() { }
    
    /// Textfield background color
    /// - Parameter value: UIColor for background
    /// - Returns: 
    public func backgroundColor(_ value: UIColor) -> FormItemTextFieldProperty {
        self.backgroundColor = value
        return self
    }
    
    /// Get textfield background color setted by user of the default color
    /// - Returns: Background color value
    func getBackgroundColor() -> UIColor? {
        return self.backgroundColor
    }
    
    /// Set textfield right icon
    /// - Parameter value: UIImage to put on right edge of textfield
    /// - Returns:
    public func rightIcon(_ value: UIImage) -> FormItemTextFieldProperty {
        self.rightIcon = value
        return self
    }
    
    /// Get right icon for textfield.
    /// - Returns: The icon to set in the right edge. Nil if image is not setted up
    func getRightIcon() -> UIImage? {
        return rightIcon
    }
    
    /// Set textfield active or not value
    /// - Parameter value: TRUE if textfield is active, FALSE otherwise. Default value is TRUE
    /// - Returns:
    public func isActive(_ value: Bool) -> FormItemTextFieldProperty {
        self.isActive = value
        return self
    }
    
    /// Get the active property of textfield.
    /// - Returns: TRUE if textfield is active, FALSE otherwise
    func getIsActive() -> Bool {
        return self.isActive ?? true
    }
    
    /// Textfield border color and width
    /// - Parameter value: UIColor for textfield border
    /// - Returns:
    public func border(color: UIColor, width: BorderWidth) -> FormItemTextFieldProperty {
        self.borderColor = color
        self.borderWidth = width
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getBorderColor() -> UIColor {
        return self.borderColor
    }
    
    /// Textfield border with setted up
    /// - Returns:CGFloat value for textfield width
    func getBorderWidth() -> CGFloat {
        return self.borderWidth.floatValue
    }
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func cornerRadius(_ value: CGFloat) -> FormItemTextFieldProperty {
        self.cornerRadius = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getCornerRadius() -> CGFloat {
        return self.cornerRadius
    }
    
    public func placeholderColor(_ value: UIColor) -> FormItemTextFieldProperty {
        self.placeholderColor = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getPlaceholderColor() -> UIColor {
        return self.placeholderColor ?? .black
    }
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func leftPaggind(_ value: LeftPadding) -> FormItemTextFieldProperty {
        self.leftPaggind = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getLeftPadding() -> CGFloat {
        return self.leftPaggind.floatValue
    }
}
