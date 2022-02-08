//
//  UITextField+Extension.swift
//  SwiftFormBuilder
//
//  Created by Alessandro Marcon on 26/05/2021.
//

import Foundation
import UIKit

extension UITextField {
    
    //MARK: - Padding
    
    /// Add a right padding on textfield
    /// - Parameter rightPadding: The size in CGFloat of right padding
    func setRightPaddingPoints(_ rightPadding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    /// Add a left padding on textfield
    /// - Parameter leftPadding: The size in CGFloat of left padding
    func setLeftPaddingPoints(_ leftPadding: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    /// Add a right icon on textfield
    /// - Parameter rightIcon: The icon to put on right corner of textfield
    func setRightIcon(_ rightIcon: UIImage, size: CGSize?) {
        var width: CGFloat = .zero
        var height: CGFloat = .zero
        
        if let customSize = size {
            width = customSize.width
            if( customSize.height <= self.frame.size.height ) {
                height = customSize.height
            } else {
                height = self.frame.size.height
            }
        } else {
            width = self.frame.size.height-30
            height = self.frame.size.height-30
        }
        
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width+10 , height: self.frame.size.height))
        let icon = UIImageView(frame: CGRect(x: 0, y: self.frame.size.height/2-height/2, width: width, height: height))
        icon.image = rightIcon
        icon.contentMode = .scaleAspectFit
        paddingView.addSubview(icon)
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    //MARK: - Round corner
    
    /// Adds a corner radius of half the height of the textfield it is applied to.
    /// - Parameter hasCorner: TRUE if corner ha rounded border, FALSE otherwise
    func hasConrnerRadius(_ hasCorner: Bool) {
        self.layer.cornerRadius = hasCorner ? self.frame.size.height/2 : .zero
    }
    
    /// Makes the edge of the textfield rounded by a specific size passed to the method.
    /// - Parameter size: The size of rounded corner
    func cornerRadius(of size: CGFloat) {
        self.layer.cornerRadius = self.frame.size.height/size
    }
    
    //MARK: - Border
    
    /// Set a custom border on textfield
    /// - Parameters:
    ///   - ofSize: The size of the border
    ///   - andColor: The color of the border
    func setBorder(ofSize: CGFloat, andColor: UIColor) {
        self.layer.borderWidth = ofSize
        self.layer.borderColor = andColor.cgColor
    }
}
