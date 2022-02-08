//
//  VTRMessageConfig.swift
//  SwiftFormBuilder
//
//  Created by Alessandro Marcon on 28/05/2021.
//

import Foundation

public class SFBMessage {
    
    public static let FIELD_NAME = "$FIELD_NAME$"
    
    //MARK: - Public instance
    /// Singleton object for SFBMessage
    static let shared: SFBMessage = SFBMessage()
    
    //MARK: - Private properties
    /// Message to show during error validation for mandatory item
    private var _mandatoryItemErrorMessage: String = "Il campo è obbligatorio"
    /// Message to show when validator checking for string but found another value type
    private var _stringValueItemErrorMessage: String = "Il valore deve essere una stringa"
    /// Message to show in case of undefined dependency field.
    private var _dependecyUndefinedErrorMessage: String = "Il campo ha una dipendenza ma di tipo indefinito"
    /// Message showed in case of equal dependecy with unmatch value.
    private var _dependecyUnmatchErrorMessage: String = "Il valore non coincide con \(FIELD_NAME)"
    /// Message showed after validation of value that doesn't match field rules. For example, if in a firstname field user fille with only numbers.
    private var _checkValueErrorMessage: String = "Controlla il valore inserito"
    /// Message showed in case of fill dependecy with unfilled value.
    private var _dependecyUnfilledErrorMessage: String = "Il campo \(FIELD_NAME) deve essere valorizzato"
    /// Message showed in case of invalid e-mail
    private var _invalidMailErrorMessage: String = "E-mail non valida"
    /// Message showed in case of unmatched password fields.ì
    private var _unmatchPasswordErrorMessage: String = "Le password non coincidono"
    /// Message showed in case of unmatched password fields.
    private var _invalidPasswordErrorMessage: String = "La password deve essere compresa tra \(SFBPasswordRule.minLength) e \(SFBPasswordRule.maxLength) caratteri \(SFBPasswordRule.needLowercasedLetter ? "un carattere minuscolo" : "") \(SFBPasswordRule.needLowercasedLetter ? "un carattere maiuscolo" : "") \(SFBPasswordRule.needSpecialChar ? "un carattere speciale" : "") \(SFBPasswordRule.needNumber ? "un numero" : "")"
    /// Message showed in case of invalid fiscal code fields.
    private var _invalidFiscalCodeErrorMessage: String = "Codice fiscale non valido"
    /// Message showed in case of invalid phone number fields.
    private var _invalidPhoneNumberErrorMessage: String = "Numero di telefono non valido"
    
    //MARK: - Initializer
    /// Default SFBMessage initializer
    private init() { }
    
    //MARK: - Public properties
    
    /// Message to show during error validation for mandatory item. Default value is "Il campo è obbligatorio"
    public static var mandatoryError: String {
        get {
            return shared._mandatoryItemErrorMessage
        }
        set {
            shared._mandatoryItemErrorMessage = newValue
        }
    }
    
    /// Message to show when validator checking for string but found another value type. Default value is "Il valore deve essere una stringa"
    public static var stringValueNotFoundError: String {
        get {
            return shared._stringValueItemErrorMessage
        }
        set {
            shared._stringValueItemErrorMessage = newValue
        }
    }
    
    ///Message to show in case of undefined dependency field. Default message is "Il campo ha una dipendenza ma di tipo indefinito"
    public static var undefinedDependecyError: String {
        get {
            return shared._dependecyUndefinedErrorMessage
        }
        set {
            shared._dependecyUndefinedErrorMessage = newValue
        }
    }
    
    /// Message showed in case of equal dependecy with unmatch value. Default message is "Il valore non coincide con $FIELD_NAME$". $FIELD_NAME$ will be replaced with dependency field title value
    public static var dependecyUnmatchError: String {
        get {
            return shared._dependecyUnmatchErrorMessage
        }
        set {
            shared._dependecyUnmatchErrorMessage = newValue
        }
    }
    
    /// Message showed after validation of value that doesn't match field rules. For example, if in a firstname field user fille with only numbers. Default message is "Controlla il valore inserito".
    public static var checkValueError: String {
        get {
            return shared._checkValueErrorMessage
        }
        set {
            shared._checkValueErrorMessage = newValue
        }
    }
    
    /// Message showed in case of fill dependecy with unfilled value. Default message is "Il campo $FIELD_NAME$ deve essere valorizzato". $FIELD_NAME$ will be replaced with dependency field title value
    public static var dependecyUnfilledError: String {
        get {
            return shared._dependecyUnfilledErrorMessage
        }
        set {
            shared._dependecyUnfilledErrorMessage = newValue
        }
    }
    
    /// Message showed in case of invalid e-mail Default message is "E-mail non valida".
    public static var invalidMailError: String {
        get {
            return shared._invalidMailErrorMessage
        }
        set {
            shared._invalidMailErrorMessage = newValue
        }
    }
    
    /// Message showed in case of unmatched password fields. Default message is "Le password non coincidono".
    public static var unmatchPasswordError: String {
        get {
            return shared._unmatchPasswordErrorMessage
        }
        set {
            shared._unmatchPasswordErrorMessage = newValue
        }
    }
    
    /// Message showed in case of unmatched password fields. Default message is "Password non valida"
    public static var invalidPasswordError: String {
        get {
            return shared._invalidPasswordErrorMessage
        }
        set {
            shared._invalidPasswordErrorMessage = newValue
        }
    }
    
    /// Message showed in case of invalid fiscal code fields. Default message is "Codice fiscale non valido"
    public static var invalidFiscalCodeError: String {
        get {
            return shared._invalidFiscalCodeErrorMessage
        }
        set {
            shared._invalidFiscalCodeErrorMessage = newValue
        }
    }
    
    /// Message showed in case of invalid phone number fields. Default message "Numero di telefono non valido"
    public static var invalidPhoneNumberError: String {
        get {
            return shared._invalidPhoneNumberErrorMessage
        }
        set {
            shared._invalidPhoneNumberErrorMessage = newValue
        }
    }
}
