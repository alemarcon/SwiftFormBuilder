//
//  FormItemButtonProperty.swift
//  SwiftFormBuilder
//
//  Created by Alessandro Marcon on 26/05/2021.
//

import Foundation
import UIKit

public enum Radius {
    
    /// Button has no corner radius
    case none
    /// Corner radius of 3 px
    case soft
    /// Corner radius of 6 px
    case medium
    /// Corner radius of 10 px
    case hard
    /// Rounded button
    case rounded
    /// Custom corner radius value. If bigger than button height, it will be set to button height
    case custom(_ round: CGFloat)
    
    var floatValue: CGFloat {
        switch self {
        case .none:
            return .zero
        case .soft:
            return CGFloat(3)
        case .medium:
            return CGFloat(6)
        case .hard:
            return CGFloat(10)
        case .rounded:
            return CGFloat(20)
        case .custom(let round):
            return round > 40 ? 40 : round
        }
    }
}

public class FormItemButtonProperty {
    
    //MARK: - Properties
    /// Element tint color
    private var backgroundColor = UIColor.white
    /// Make field active or not
    private var isActive: Bool?
    /// Button title color
    private var titleColor: UIColor = .white
    /// Button corner radius
    private var cornerRadius: Radius = .none
    /// Button border color
    private var borderColor: UIColor = .clear
    /// Button border width
    private var borderWidth: CGFloat = .zero
    
    public init() { }
    
    //MARK: - Getter and setter
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func backgroundColor(_ value: UIColor) -> FormItemButtonProperty {
        self.backgroundColor = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getBackgroundColor() -> UIColor? {
        return self.backgroundColor
    }
    
    /// Set textfield active or not value
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func isActive(_ value: Bool) -> FormItemButtonProperty {
        self.isActive = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getIsActive() -> Bool {
        return self.isActive ?? true
    }
    
    /// Set button title color
    /// - Parameter values: UIColor object
    /// - Returns:
    public func titleColor(_ values: UIColor) -> FormItemButtonProperty {
        self.titleColor = values
        return self
    }
    
    /// Get button title color
    /// - Returns: 
    func getTitleColor() -> UIColor {
        return titleColor
    }
    
    /// Set button corner radius
    /// - Parameter value: Radius value
    /// - Returns: <#description#>
    public func radius(_ value: Radius) -> FormItemButtonProperty {
        self.cornerRadius = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getCornerRadius() -> CGFloat {
        return cornerRadius.floatValue
    }
    
    public func border(width: CGFloat, color: UIColor) -> FormItemButtonProperty {
        self.borderColor = color
        self.borderWidth = width
        return self
    }
    
    /// Get button border color
    /// - Returns: UIColor for border. Default is clear
    func getBorderColor() -> UIColor {
        return self.borderColor
    }
    
    /// Get button border width
    /// - Returns: Size of border width. Default is zero
    func getBorderWidth() -> CGFloat {
        return self.borderWidth
    }
}
