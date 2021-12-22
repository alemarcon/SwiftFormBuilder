//
//  FormValidatorDelegate.swift
//  SwiftFormBuilder
//
//  Created by Alessandro Marcon on 17/05/2021.
//

import Foundation

//MARK: - Validator delegate method
/// Contains methods that will be called on form items validations
public protocol FormValidatorDelegate {
    func validationButtonDidPressed()
    func checkboxDidPressed(for item: String, isSelected: Bool)
}

//MARK: - Form Validator Protocol
/// Delegate object for validation
public protocol FormValidator {
    var delegate: FormValidatorDelegate? { get set }
}

//MARK: - Model
/// The model returned from FormBuilder after form items validation
public struct ValidatedItem {
    let name: String
    let value: Any
    
    init(name: String, value: Any) {
        self.name = name
        self.value = value
    }
}
