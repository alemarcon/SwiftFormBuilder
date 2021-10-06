//
//  VetryaTextField.swift
//  VTRFormBuilder
//
//  Created by Alessandro Marcon on 26/05/2021.
//

import Foundation
import UIKit

@IBDesignable
class VetryaTextField: UITextField {
    
    private var cornersSet: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
        updateColor()
        updateBorder()
    }
    
    /// Add round corner to button
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var roundedRadius: CGFloat = 0.0 {
        didSet {
            updateCornerRadius()
        }
    }
    
    /// <#Description#>
    private func updateCornerRadius() {
        if rounded {
            layer.cornerRadius = roundedRadius > 0.0 ? roundedRadius : (frame.size.height / 2)
        }else {
            layer.cornerRadius = 0
        }
    }
    
    /// Add a border line to the button
    @IBInspectable var border: CGFloat = .zero {
        didSet {
            updateBorder()
        }
    }

    /// Change border button color
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            updateColor()
        }
    }
    
    /// Update border botton color
    private func updateColor() {
        layer.borderColor = borderColor.cgColor
    }

    /// Update button border width
    private func updateBorder() {
        layer.borderWidth = border
    }
    
}
