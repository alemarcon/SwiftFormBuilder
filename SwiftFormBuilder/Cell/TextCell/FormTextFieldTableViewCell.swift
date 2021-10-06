//
//  FormTextFieldTableViewCell.swift
//  Supertennis
//
//  Created by Alessandro Marcon on 12/05/2021.
//

import UIKit

class FormTextFieldTableViewCell: UITableViewCell, FormConformity {
    
    @IBOutlet weak var nameTextfieldLabel: UILabel!
    @IBOutlet weak var textField: VetryaTextField!
    @IBOutlet weak var errorTextfieldLabel: UILabel!
    
    var formItem: FormItem?
    
    fileprivate var isUIConfigured = false
    static var NIB_NAME = "FormTextFieldTableViewCell"
    static var IDENTIFIER = "text_field_cell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hasError(false, message: nil)
        textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - hasError: <#hasError description#>
    ///   - message: <#message description#>
    fileprivate func hasError(_ hasError: Bool, message: String?) {
        errorTextfieldLabel.alpha = hasError ? 0 : 1
        if let _message = message {
            errorTextfieldLabel.text = _message
            errorTextfieldLabel.sizeToFit()
            textField.borderColor = formItem?.getUIProperties().getErrorColor() ?? .red
        } else {
            errorTextfieldLabel.text = ""
            errorTextfieldLabel.sizeToFit()
            textField.borderColor = formItem?.getUIProperties().getTextfieldProperty()?.getBorderColor() ?? .black
        }
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        self.formItem = self.formItem?.value(textField.text!)
    }
    
}

// MARK: - FormUpdatable
extension FormTextFieldTableViewCell: FormUpdatable {
    
    func update(with formItem: FormItem) {
        self.formItem = formItem
        
        if let formItem = self.formItem {
            if let val = formItem.getValue() as? String {
                textField.text = val
            } else {
                textField.text = ""
            }
            
            if let fieldname = formItem.getTitle() {
                nameTextfieldLabel.text = fieldname + (formItem.getMandatory() ? "*" : "")
            }
            
            hasError(formItem.getIsValid(), message: formItem.getFormItemErrorMessage())
            
            if( !isUIConfigured ) {
                // Configure textfield UI properties
                textField.keyboardType = formItem.getUIProperties().getKeyboardType()
                textField.attributedPlaceholder = NSAttributedString(string: formItem.getPlaceholder() ?? "", attributes: [NSAttributedString.Key.foregroundColor: formItem.getUIProperties().getTextfieldProperty()?.getPlaceholderColor() ?? UIColor.VetryaColor.lightGrey])
                textField.tintColor = formItem.getUIProperties().getTintColor()
                
                if let textfieldProperty = formItem.getUIProperties().getTextfieldProperty() {
                    textField.isEnabled = textfieldProperty.getIsActive()
                    
                    if let rightIcon = textfieldProperty.getRightIcon() {
                        textField.setRightIcon(rightIcon, size: nil)
                    }
                    
                    textField.borderColor = textfieldProperty.getBorderColor()
                    textField.border = textfieldProperty.getBorderWidth()
                    
                    if( textfieldProperty.getCornerRadius() > .zero ) {
                        textField.rounded = true
                        textField.roundedRadius = textfieldProperty.getCornerRadius() > textField.frame.size.height/2 ? textField.frame.size.height/2 : textfieldProperty.getCornerRadius()
                    } else {
                        textField.rounded = false
                    }
                    
                    let leftPadding = textfieldProperty.getLeftPadding() > textField.frame.size.width/2 ? textField.frame.size.width/2 : textfieldProperty.getLeftPadding()
                    textField.setLeftPaddingPoints( leftPadding )
                    
                    textField.backgroundColor = textfieldProperty.getBackgroundColor()
                }
                
                isUIConfigured = true
            }
            
            let type = formItem.getValueType() ?? .text
            
            if( type == .password || type == .confirmPassword ) {
                textField.isSecureTextEntry = true
            } else {
                textField.isSecureTextEntry = false
            }
        }
    }
    
}
