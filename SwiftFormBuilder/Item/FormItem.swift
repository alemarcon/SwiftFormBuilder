//
//  FormItem.swift
//  Supertennis
//
//  Created by Alessandro Marcon on 12/05/2021.
//

import Foundation

public enum ValueItemType {
    // item with free text entry
    case text
    // First nama field
    case firstname
    // Lastname field
    case lastname
    // Username field
    case username
    // Email field
    case email
    // Password field
    case password
    // Password field
    case confirmPassword
    // Date field
    case date
    // Phone number field
    case phonenumber
    // Fiscal code field
    case fiscalCode
    // Checkbox field
    case checkbox
    // Field to be discarded during validation
    case discardable
}


public class FormItem {
    
    /// Name given to item form. Used to collect data on validation button pressed
    private var itemName: String
    /// Title value. Used as top textfield label
    private var title: String?
    /// In case of tappable link, we could have an underlined part of the title.
    private var underlinedTitlePart: String?
    /// Error message to show in case of validation fails.
    private var formItemErrorMessage: String?
    /// Value of current item, could be String, Bool, Int ecc
    private var value: Any?
    /// TextField placeholder value
    private var placeholder: String?
    /// IndexPath for cell that own current item
    private var indexPath: IndexPath?
    /// Generic UI properties for form item
    private var uiProperties = FormItemUIProperties(itemType: .textfield)
    /// Properties applied to form items of picket type
    private var pickerProperties = FormItemPickerProperties(doneButtonTitle: "Done", cancelButtonTitle: "Cancel")
    /// The array of values for pickers
    private var pickerValues: [PickerValue]?
    /// The value type of current item
    private var valueType: ValueItemType?
    /// The link url to open when items is kind of LinkTextCell
    private var link: URL?
    /// Item to depend on
    private var dependence: DependenceItem?
    /// Items to do some actions when value of current items change
    private var actionItems: [ActionItem]?
    /// Contains the item validity after form validation operations
    private var isValid: Bool = true
    /// Set item mandatory or not. Default value is not mandatory
    private var isMandatory: Bool = false
    /// Reference of server policy model. Used in checkbox with policy cases
    private var policy: PolicyModel?
    ///
    private var passwordProperty: FormItemPasswordProperty?
    
    //MARK: - Init
    public init(named: String, valueType: ValueItemType) {
        self.itemName = named
        self.valueType = valueType
    }
    
    //MARK: - Getter and setter
    public func getItemName() -> String {
        return itemName
    }
    
    /// Set cell title label over the textfield
    /// - Parameter value: The title of the cell
    /// - Returns: Current FormItem object
    public func title(_ value: String) -> FormItem {
        self.title = value
        return self
    }
    
    public func title(_ value: String, underlined: String) -> FormItem {
        self.title = value
        self.underlinedTitlePart = underlined
        return self
    }
    
    /// Get cell label title value
    /// - Returns: Current title value string. Nil if wasn't setted up
    func getTitle() -> String? {
        return self.title
    }
    
    func getUnderlinedPartTitle() -> String? {
        return self.underlinedTitlePart
    }
    
    /// Return the current error message for item
    /// - Returns: <#description#>
    func getFormItemErrorMessage() -> String? {
        return self.formItemErrorMessage
    }
    
    /// The value of current elemente
    /// - Parameter value: Value of element. Could be any value. String, Int, Bool etc.
    /// - Returns: <#description#>
    public func value(_ value: Any) -> FormItem {
        self.value = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getValue() -> Any? {
        return self.value
    }
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func placeholder(_ value: String) -> FormItem {
        self.placeholder = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getPlaceholder() -> String? {
        return self.placeholder
    }
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    func indexPath(_ value: IndexPath) -> FormItem {
        self.indexPath = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getIndexPath() -> IndexPath? {
        return self.indexPath
    }
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func uiProperties(_ value: FormItemUIProperties) -> FormItem {
        self.uiProperties = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getUIProperties() -> FormItemUIProperties {
        return self.uiProperties
    }
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func pickerProperties(_ value: FormItemPickerProperties) -> FormItem {
        self.pickerProperties = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getPickerProperties() -> FormItemPickerProperties {
        return self.pickerProperties
    }
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func isMandatory(_ value: Bool) -> FormItem {
        self.isMandatory = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getMandatory() -> Bool {
        return self.isMandatory
    }
    
    /// Set ttype for textfield. Used to check validity
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func valueType(_ value: ValueItemType) -> FormItem {
        self.valueType = value
        return self
    }
    
    /// Return the current textfield type
    /// - Returns: Object of type TextFieldItemType. Nil if wasn't setted up
    func getValueType() -> ValueItemType? {
        return self.valueType
    }
    
    public func pickerValues( values: [PickerValue]) -> FormItem {
        self.pickerValues = values
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getPickerValues() -> [PickerValue]? {
        return self.pickerValues
    }
    
    /// Set link for cell that provide a tappable link label
    /// - Parameter value: URL object to be opened
    /// - Returns:
    public func link(_ value: URL?) -> FormItem {
        self.link = value
        return self
    }
    
    /// Return the link variable.
    /// - Returns: URL Object or NIL if is it not setted up
    func getLink() -> URL? {
        return self.link
    }
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func depend(on value: DependenceItem) -> FormItem {
        self.dependence = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getDependence() -> DependenceItem? {
        return self.dependence
    }
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func action(on value: [ActionItem]) -> FormItem {
        self.actionItems = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getActionItems() -> [ActionItem]? {
        return self.actionItems
    }
    
    /// Set the validity of the item
    /// - Parameter value: Item validity. TRUE if valid, FALSE otherwise
    /// - Returns:
    func setValid(_ value: Bool) -> FormItem {
        self.isValid = value
        return self
    }
    
    /// Get item validity values
    /// - Returns: TRUE for valid item, FALSE otherwise
    func getIsValid() -> Bool {
        return self.isValid
    }
    
    /// Set the policy item
    /// - Parameter value: Item validity. TRUE if valid, FALSE otherwise
    /// - Returns:
    public func policy(_ value: PolicyModel) -> FormItem {
        self.policy = value
        return self
    }
    
    /// Get item validity values
    /// - Returns: TRUE for valid item, FALSE otherwise
    func getPolicyModel() -> PolicyModel? {
        return self.policy
    }
    
    /// Set password field validation rules
    public func passwordRules(_ value: FormItemPasswordProperty) -> FormItem {
        self.passwordProperty = value
        return self
    }
    
    
    //MARK: - Cell validation
    func checkValidity() {
        
        var fieldValid = true
        var errorMessage: String?
        
        switch valueType {
        case .text:
            let result = validateFreetext()
            fieldValid = result.0
            errorMessage = result.1
        case .firstname:
            let result = validateFisrtOrLastName()
            fieldValid = result.0
            errorMessage = result.1
        case .lastname:
            let result = validateFisrtOrLastName()
            fieldValid = result.0
            errorMessage = result.1
        case .email:
            let result = validateMail()
            fieldValid = result.0
            errorMessage = result.1
        case .password:
            let result = validatePassword()
            fieldValid = result.0
            errorMessage = result.1
        case .confirmPassword:
            let result = validatePassword()
            fieldValid = result.0
            errorMessage = result.1
        case .date:
            let result = validateDate()
            fieldValid = result.0
            errorMessage = result.1
        case .username:
            let result = validateFreetext()
            fieldValid = result.0
            errorMessage = result.1
        case .phonenumber:
            let result = validatePhoneNumber()
            fieldValid = result.0
            errorMessage = result.1
        case .fiscalCode:
            let result = validateFiscalCode()
            fieldValid = result.0
            errorMessage = result.1
        case .checkbox:
            let result = validateCheckbox()
            fieldValid = result.0
            errorMessage = result.1
        case .discardable, .none:
            Logger.print(level: .warning, "\(title ?? "unknow") is Discardable. Will not be validated")
            fieldValid = true
            formItemErrorMessage = nil
        }
        
        isValid = fieldValid
        formItemErrorMessage = errorMessage
    }
    
    
    /// Validate free text field. Cheking is item is not nil, if value is string, if is mandatory and string not empty.
    /// - Returns: TRUE with nil message if valid, FALSE with error message otherwise
    private func validateFreetext() -> (Bool, String?) {
        Logger.print(level: .verbose, "Check validity for text item")
        
        guard let currentItemValue = value else {
            if( isMandatory ) {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item is mandataory")
                return(false, VTRMessage.mandatoryError)
            } else {
                return(true, nil)
            }
        }
        
        guard let textValue = currentItemValue as? String else {
            Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item value type not string")
            return(false, VTRMessage.stringValueNotFoundError)
        }
        
        if( isMandatory && textValue.isEmpty ) {
            Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item is mandataory")
            return(false, VTRMessage.mandatoryError)
        } else {
            return(true, nil)
        }
    }
    
    
    /// Validate first or last name field. Cheking is item is not nil, if value is string, if is mandatory and string not empty.
    /// - Returns: TRUE with nil message if valid, FALSE with error message otherwise
    private func validateFisrtOrLastName() -> (Bool, String?) {
        Logger.print(level: .verbose, "Check validity for name item")
        
        guard let currentItemValue = value else {
            if( isMandatory ) {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item is mandataory")
                return(false, VTRMessage.mandatoryError)
            } else {
                return(true, nil)
            }
        }
        
        guard let textValue = currentItemValue as? String else {
            Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item value type not string")
            return(false, VTRMessage.stringValueNotFoundError)
        }
        
        if( isMandatory ) {
            if( textValue.isEmpty ) {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item is mandataory")
                return(false, VTRMessage.mandatoryError)
            } else {
                if( textValue.isValidFirstLastName() ) {
                    
                    if let dependency = dependence {
                        // Check if dependency field was filled
                        if( dependency.getType() == .fill ) {
                            if( dependency.getDependencyItem().getValue() == nil ) {
                                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item \(dependency.getDependencyItem().getTitle() ?? "unknow") must be filled")
                                return(false, VTRMessage.dependecyUnfilledError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-") )
                            } else {
                                return(true, nil)
                            }
                        }
                        
                        if( dependency.getType() == .equal ) {
                            // Check if dependency field value and it's own value are equal
                            if let field = dependency.getDependencyItem().getValue() as? String {
                                if( textValue != field ) {
                                    Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Must be equal to \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                                    return(false, VTRMessage.dependecyUnmatchError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-") )
                                } else {
                                    return(true, nil)
                                }
                            } else {
                                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Must be equal to \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                                return(false, VTRMessage.dependecyUnmatchError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-") )
                            }
                        }
                        
                        Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item has dependecy but unable to find dependecy field \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                        return(false, VTRMessage.undefinedDependecyError)
                    } else {
                        return(true, nil)
                    }
                    
                } else {
                    Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Invalid first ot last name value -> \(currentItemValue)")
                    return(false, VTRMessage.checkValueError)
                }
            }
        } else {
            if( !textValue.isEmpty && !textValue.isValidFirstLastName() ) {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Invalid first ot last name value -> \(currentItemValue)")
                return(false, VTRMessage.checkValueError)
            } else {
                return(true, nil)
            }
        }
    }
    
    /// Validate first or last name field. Cheking is item is not nil, if value is string, if is mandatory and string not empty.
    /// - Returns: TRUE with nil message if valid, FALSE with error message otherwise
    private func validateMail() -> (Bool, String?) {
        Logger.print(level: .verbose, "Check validity for email item")
        
        guard let currentItemValue = value else {
            if( isMandatory ) {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item is mandataory")
                return(false, VTRMessage.mandatoryError)
            } else {
                return(true, nil)
            }
        }
        
        guard let textValue = currentItemValue as? String else {
            Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item value type not string")
            return(false, VTRMessage.stringValueNotFoundError)
        }
        
        if( isMandatory ) {
            if( textValue.isEmpty ) {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item is mandataory")
                return(false, VTRMessage.mandatoryError)
            } else {
                if( textValue.isValidEmailAddress() ) {
                    
                    if let dependency = dependence {
                        // Check if dependency field was filled
                        if( dependency.getType() == .fill ) {
                            if( dependency.getDependencyItem().getValue() == nil ) {
                                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item \(dependency.getDependencyItem().getTitle() ?? "unknow") must be filled")
                                return(false, VTRMessage.dependecyUnfilledError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-") )
                            } else {
                                return(true, nil)
                            }
                        }
                        
                        if( dependency.getType() == .equal ) {
                            // Check if dependency field value and it's own value are equal
                            if let field = dependency.getDependencyItem().getValue() as? String {
                                if( textValue != field ) {
                                    Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Must be equal to \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                                    return(false, VTRMessage.dependecyUnmatchError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-") )
                                } else {
                                    return(true, nil)
                                }
                            } else {
                                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Must be equal to \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                                return(false, VTRMessage.dependecyUnmatchError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-") )
                            }
                        }
                        
                        Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item has dependecy but unable to find dependecy field \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                        return(false, VTRMessage.undefinedDependecyError)
                    } else {
                        return(true, nil)
                    }
                    
                } else {
                    Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Invalid email -> \(currentItemValue)")
                    return(false, VTRMessage.invalidMailError)
                }
            }
        } else {
            if( !textValue.isEmpty && !textValue.isValidEmailAddress() ) {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Invalid email value -> \(currentItemValue)")
                return(false, VTRMessage.invalidMailError)
            } else {
                return(true, nil)
            }
        }
    }
    
    /// Validate password field. Password is always considered mandatory, and should be min 8 chars, at least 1 uppercased char and 1 special chars
    /// - Returns: TRUE with nil message if valid, FALSE with error message otherwise
    private func validatePassword() -> (Bool, String?) {
        Logger.print(level: .verbose, "Check validity for password item")
        
        guard let currentItemValue = value else {
            if( isMandatory ) {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item is mandataory")
                return(false, VTRMessage.mandatoryError)
            } else {
                return(true, nil)
            }
        }
        
        guard let textValue = currentItemValue as? String else {
            Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item value type not string")
            return(false, VTRMessage.stringValueNotFoundError)
        }
        
        if( textValue.isEmpty ) {
            Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item is mandataory")
            return(false, VTRMessage.mandatoryError)
        } else {
            if( textValue.isValidPassword() ) {
                if let dependency = dependence {
                    // Check if dependency field was filled
                    if( dependency.getType() == .fill ) {
                        if( dependency.getDependencyItem().getValue() == nil ) {
                            Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item \(dependency.getDependencyItem().getTitle() ?? "unknow") must be filled")
                            return(false, VTRMessage.dependecyUnfilledError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-"))
                        } else {
                            return(true, nil)
                        }
                    }
                    
                    if( dependency.getType() == .equal ) {
                        // Check if dependency field value and it's own value are equal
                        if let field = dependency.getDependencyItem().getValue() as? String {
                            if( textValue != field ) {
                                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Password must be equal to \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                                return(false, VTRMessage.unmatchPasswordError)
                            } else {
                                return(true, nil)
                            }
                        } else {
                            return(false, VTRMessage.unmatchPasswordError)
                        }
                    }
                    
                    Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item has dependecy but unable to find dependecy field \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                    return(false, VTRMessage.undefinedDependecyError)
                } else {
                    return(true, nil)
                }
            } else {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Invalid password")
                return(false, VTRMessage.invalidPasswordError)
            }
        }
    }
    
    
    /// Validate fiscal code field. Cheking is item is not nil, if value is string, if is mandatory and string not empty.
    /// - Returns: TRUE with nil message if valid, FALSE with error message otherwise
    private func validateFiscalCode() -> (Bool, String?) {
        Logger.print(level: .verbose, "Check validity for fiscal code item")
        
        guard let currentItemValue = value else {
            if( isMandatory ) {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item is mandataory")
                return(false, VTRMessage.mandatoryError)
            } else {
                return(true, nil)
            }
        }
        
        guard let textValue = currentItemValue as? String else {
            Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item value type not string")
            return(false, VTRMessage.stringValueNotFoundError)
        }
        
        if( isMandatory ) {
            if( textValue.isEmpty ) {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item is mandataory")
                return(false, VTRMessage.mandatoryError)
            } else {
                if( textValue.isValidFiscalCode() ) {
                    if let dependency = dependence {
                        // Check if dependency field was filled
                        if( dependency.getType() == .fill ) {
                            if( dependency.getDependencyItem().getValue() == nil ) {
                                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item \(dependency.getDependencyItem().getTitle() ?? "unknow") must be filled")
                                return(false, VTRMessage.dependecyUnfilledError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-"))
                            } else {
                                return(true, nil)
                            }
                        }
                        
                        if( dependency.getType() == .equal ) {
                            // Check if dependency field value and it's own value are equal
                            if let field = dependency.getDependencyItem().getValue() as? String {
                                if( textValue != field ) {
                                    Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Must be equal to \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                                    return(false, VTRMessage.dependecyUnmatchError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-"))
                                } else {
                                    return(true, nil)
                                }
                            } else {
                                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Must be equal to \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                                return(false, VTRMessage.dependecyUnmatchError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-"))
                            }
                        }
                        
                        Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item has dependecy but unable to find dependecy field \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                        return(false, VTRMessage.undefinedDependecyError)
                    } else {
                        return(true, nil)
                    }
                } else {
                    Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Invalid fiscal code")
                    return(false, VTRMessage.invalidFiscalCodeError)
                }
            }
        } else {
            if( !textValue.isEmpty && !textValue.isValidFiscalCode() ) {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Invalid fiscal code value -> \(currentItemValue)")
                return(false, VTRMessage.invalidFiscalCodeError)
            } else {
                return(true, nil)
            }
        }
    }
    
    /// Validate checkbox checking if is mandatory, if is selected or not, if has depen
    /// - Returns: TRUE with nil message if valid, FALSE with error message otherwise
    private func validateCheckbox() -> (Bool, String?) {
        Logger.print(level: .verbose, "Check validity for checkbox code item")
        
        guard let currentItemValue = value else {
            if( isMandatory ) {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item is mandataory")
                return(false, VTRMessage.mandatoryError)
            } else {
                return(true, nil)
            }
        }
        
        guard let boolValue = currentItemValue as? Bool else {
            Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item value type not string")
            return(false, VTRMessage.stringValueNotFoundError)
        }
        
        if( isMandatory ) {
            if( !boolValue ) {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item is mandataory")
                return(false, VTRMessage.mandatoryError)
            } else {
                if let dependency = dependence {
                    // Check if dependency field was filled
                    if( dependency.getType() == .fill ) {
                        if( dependency.getDependencyItem().getValue() == nil ) {
                            Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item \(dependency.getDependencyItem().getTitle() ?? "unknow") must be filled")
                            return(false, VTRMessage.dependecyUnfilledError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-"))
                        } else {
                            return(true, nil)
                        }
                    }
                    
                    if( dependency.getType() == .equal ) {
                        // Check if dependency field value and it's own value are equal
                        if let field = dependency.getDependencyItem().getValue() as? Bool {
                            if( !field ) {
                                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Must be equal to \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                                return(false, VTRMessage.dependecyUnmatchError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-"))
                            } else {
                                return(true, nil)
                            }
                        } else {
                            Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Must be equal to \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                            return(false, VTRMessage.dependecyUnmatchError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-"))
                        }
                    }
                    
                    Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item has dependecy but unable to find dependecy field \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                    return(false, VTRMessage.undefinedDependecyError)
                } else {
                    return(true, nil)
                }
            }
        } else {
            return(true, nil)
        }
    }
    
    
    /// <#Description#>
    /// - Returns: <#description#>
    private func validatePhoneNumber() -> (Bool, String?) {
        Logger.print(level: .verbose, "Check validity for phone numbder item")
        
        guard let currentItemValue = value else {
            if( isMandatory ) {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item is mandataory")
                return(false, VTRMessage.mandatoryError)
            } else {
                return(true, nil)
            }
        }
        
        guard let textValue = currentItemValue as? String else {
            Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item value type not string")
            return(false, VTRMessage.stringValueNotFoundError)
        }
        
        if( isMandatory ) {
            if( textValue.isEmpty ) {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item is mandataory")
                return(false, VTRMessage.mandatoryError)
            } else {
                if( textValue.isValidPhoneNumber() ) {
                    if let dependency = dependence {
                        // Check if dependency field was filled
                        if( dependency.getType() == .fill ) {
                            if( dependency.getDependencyItem().getValue() == nil ) {
                                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item \(dependency.getDependencyItem().getTitle() ?? "unknow") must be filled")
                                return(false, VTRMessage.dependecyUnfilledError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-"))
                            } else {
                                return(true, nil)
                            }
                        }
                        
                        if( dependency.getType() == .equal ) {
                            // Check if dependency field value and it's own value are equal
                            if let field = dependency.getDependencyItem().getValue() as? String {
                                if( textValue != field ) {
                                    Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Must be equal to \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                                    return(false, VTRMessage.dependecyUnmatchError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-"))
                                } else {
                                    return(true, nil)
                                }
                            } else {
                                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Must be equal to \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                                return(false, VTRMessage.dependecyUnmatchError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-"))
                            }
                        }
                        
                        Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item has dependecy but unable to find dependecy field \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                        return(false, VTRMessage.undefinedDependecyError)
                    } else {
                        return(true, nil)
                    }
                } else {
                    Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Invalid phone number -> \(currentItemValue)")
                    return(false, VTRMessage.invalidPhoneNumberError)
                }
            }
        } else {
            if( !textValue.isEmpty && !textValue.isValidPhoneNumber() ) {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Invalid phone number -> \(currentItemValue)")
                return(false, VTRMessage.invalidPhoneNumberError)
            } else {
                return(true, nil)
            }
        }
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    private func validateDate() -> (Bool, String?) {
        Logger.print(level: .verbose, "Check validity for date item")
        
        guard let currentItemValue = value else {
            if( isMandatory ) {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item is mandataory")
                return(false, VTRMessage.mandatoryError)
            } else {
                return(true, nil)
            }
        }
        
        guard let textValue = currentItemValue as? String else {
            Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item value type not string")
            return(false, VTRMessage.stringValueNotFoundError)
        }
        
        if( isMandatory ) {
            if( textValue.isEmpty ) {
                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item is mandataory")
                return(false, VTRMessage.invalidPhoneNumberError)
            } else {
                if let dependency = dependence {
                    // Check if dependency field was filled
                    if( dependency.getType() == .fill ) {
                        if( dependency.getDependencyItem().getValue() == nil ) {
                            Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item \(dependency.getDependencyItem().getTitle() ?? "unknow") must be filled")
                            return(false, VTRMessage.dependecyUnfilledError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-"))
                        } else {
                            return(true, nil)
                        }
                    }
                    
                    if( dependency.getType() == .equal ) {
                        // Check if dependency field value and it's own value are equal
                        if let field = dependency.getDependencyItem().getValue() as? String {
                            if( textValue != field ) {
                                Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Must be equal to \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                                return(false, VTRMessage.dependecyUnmatchError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-"))
                            } else {
                                return(true, nil)
                            }
                        } else {
                            Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Must be equal to \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                            return(false, VTRMessage.dependecyUnmatchError.replacingOccurrences(of: VTRMessage.FIELD_NAME, with: dependency.getDependencyItem().getTitle() ?? "-"))
                        }
                    }
                    
                    Logger.print(level: .warning, "Error validating \(title ?? "unknow"). Item has dependecy but unable to find dependecy field \(dependency.getDependencyItem().getTitle() ?? "unknow")")
                    return(false, VTRMessage.undefinedDependecyError)
                } else {
                    return(true, nil)
                }
                
            }
        } else {
            return(true, nil)
        }
    }
    
}
