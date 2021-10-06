//
//  VetryaButton.swift
//  VTRFormBuilder
//
//  Created by Alessandro Marcon on 27/05/2021.
//

import Foundation
import UIKit

@IBDesignable class VetryaButton: UIButton {
    
    private var cornersSet: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
        updateColor()
        updateBorder()
    }
    
    /// <#Description#>    
    @IBInspectable var roundedRadius: CGFloat = 0.0 {
        didSet {
            updateCornerRadius()
        }
    }
    
    /// <#Description#>
    @IBInspectable var shadow: Bool = false {
        didSet {
            updateShadow()
        }
    }
    
    /// <#Description#>
    private func updateCornerRadius() {
        if !cornersSet {
            cornersSet = true
            layer.cornerRadius = roundedRadius <= (frame.size.height / 2) ? roundedRadius : (frame.size.height / 2)
        }
    }
    
    /// <#Description#>
    func updateShadow() {
        if( shadow ) {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.2
            layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }
    
    /// Add a border line to the botton
    @IBInspectable var border: CGFloat = 0 {
        didSet {
            updateBorder()
        }
    }

    /// Change border botton color
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            updateColor()
        }
    }
    
    /// Update border botton color
    private func updateColor() {
        layer.borderColor = borderColor.cgColor
    }

    /// Update botton border width
    private func updateBorder() {
        layer.borderWidth = border
    }
    
}
