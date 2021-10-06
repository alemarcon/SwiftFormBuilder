//
//  VTRPasswordRule.swift
//  VTRFormBuilder
//
//  Created by Alessandro Marcon on 28/05/2021.
//

import Foundation

class VTRPasswordRule {
    
    /// Singleton object for VetryaOAuthConf
    static let shared: VTRPasswordRule = VTRPasswordRule()
    /// Minimum char for password fields. Default is 2. If number is less than 2 or greater than  _maxPasswordCharNumbers, default value will be setted
    private var _minPasswordCharNumbers: Int = 8
    /// Maximium char for password fields. Default is 15. If number is less than minLenght, default value will be setted
    private var _maxPasswordCharNumbers: Int = 40
    /// TRUE if need at least one uppercased letter, FALSE otherwise
    private var _uppercasedLetter: Bool = false
    /// TRUE if need at least one lowercased letter, FALSE otherwise
    private var _lowercaseLetter: Bool = true
    /// TRUE if need at least one special characters, FALSE otherwise. Special chars are #?!@$%^&*£|)(-;
    private var _specialCharacter: Bool = false
    /// TRUE if need at least one number, FALSE otherwise.
    private var _number: Bool = false
    
    /// Default VetryaOAuthConf initializer
    private init() { }
    
    /// Minimum char for password fields. Default is 2. If number is less than 2 or greater than  _maxPasswordCharNumbers, default value will be setted
    static var minLength: Int {
        get {
            return shared._minPasswordCharNumbers
        }
        set {
            if( newValue >= 2 && newValue < shared._maxPasswordCharNumbers ) {
                shared._minPasswordCharNumbers = newValue
            } else {
                shared._minPasswordCharNumbers = 8
            }
        }
    }
    
    /// Maximium char for password fields. Default is 15. If number is less than minLenght, default value will be setted
    static var maxLength: Int {
        get {
            return shared._maxPasswordCharNumbers
        }
        set {
            if( newValue > shared._minPasswordCharNumbers ) {
                shared._maxPasswordCharNumbers = newValue
            } else {
                shared._maxPasswordCharNumbers = 40
            }
        }
    }
    
    /// TRUE if need at least one uppercased letter, FALSE otherwise
    static var needUppercasedLetter: Bool {
        get {
            return shared._uppercasedLetter
        }
        set {
            shared._uppercasedLetter = newValue
        }
    }
    
    /// TRUE if need at least one lowercased letter, FALSE otherwise
    static var needLowercasedLetter: Bool {
        get {
            return shared._lowercaseLetter
        }
        set {
            shared._lowercaseLetter = newValue
        }
    }
    
    /// TRUE if need at least one special characters, FALSE otherwise. Special chars are #?!@$%^&*£|)(-;
    static var needSpecialChar: Bool {
        get {
            return shared._specialCharacter
        }
        set {
            shared._specialCharacter = newValue
        }
    }
    
    static var needNumber: Bool {
        get {
            return shared._number
        }
        set {
            shared._number = newValue
        }
    }
    
}
