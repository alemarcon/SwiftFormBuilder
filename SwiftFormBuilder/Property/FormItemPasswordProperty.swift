//
//  FormItemPasswordProperty.swift
//  VTRFormBuilder
//
//  Created by Alessandro Marcon on 28/05/2021.
//

import Foundation

public class FormItemPasswordProperty {
    
    //MARK: - Properties
    /// Element tint color
    private var _minLength: Int = VTRPasswordRule.minLength
    /// Make field active or not
    private var _maxLength: Int = VTRPasswordRule.maxLength
    /// Button title color
    private var _uppercased: Bool = VTRPasswordRule.needUppercasedLetter
    /// Button corner radius
    private var _lowercased: Bool = VTRPasswordRule.needLowercasedLetter
    /// Button border color
    private var _specialChars: Bool = VTRPasswordRule.needSpecialChar
    /// Button border width
    private var _numbers: Bool = VTRPasswordRule.needNumber
    
    public init() { }
    
    /// Minimum charcaters for password validity. Default is 8
    /// - Parameter value:
    /// - Returns:
    public func minLength(_ value: Int) -> FormItemPasswordProperty {
        VTRPasswordRule.minLength = value
        return self
    }
    
    /// Max charachters accepted for password validity.
    /// - Parameter value:
    /// - Returns:
    public func maxLength(_ value: Int) -> FormItemPasswordProperty {
        VTRPasswordRule.maxLength = value
        return self
    }
    
    /// TRUE if at least one uppercased letters is needed for password. FALSE otherwise
    /// - Parameter value:
    /// - Returns:
    public func needUppercasedLetters(_ value: Bool) -> FormItemPasswordProperty {
        self._uppercased = value
        VTRPasswordRule.needUppercasedLetter = value
        return self
    }
    
    /// TRUE if at least one lowercased letters is needed for password. FALSE otherwise. Default value is TRUE
    /// - Parameter value:
    /// - Returns:
    public func needLowercasedLetters(_ value: Bool) -> FormItemPasswordProperty {
        self._lowercased = value
        VTRPasswordRule.needLowercasedLetter = value
        return self
    }
    
    /// TRUE if at least one special character is needed for password. FALSE otherwise. Special chars are #?!@$%^&*£|)(-;
    /// - Parameter value:
    /// - Returns: 
    public func needSpecialChars(_ value: Bool) -> FormItemPasswordProperty {
        self._specialChars = value
        VTRPasswordRule.needSpecialChar = value
        return self
    }
    
    /// TRUE if at least one number is needed for password. FALSE otherwise
    /// - Parameter value:
    /// - Returns: 
    public func needNumber(_ value: Bool) -> FormItemPasswordProperty {
        self._numbers = value
        VTRPasswordRule.needNumber = value
        return self
    }

}
