//
//  FormPickerTableViewCell.swift
//  Supertennis
//
//  Created by Alessandro Marcon on 13/05/2021.
//

import UIKit

public struct PickerValue {
    let title: String
    let value: String
    
    public init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}

public class FormPickerTableViewCell: UITableViewCell, FormConformity {

    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextField: VetryaTextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    //MARK: - Properties
    var formItem: FormItem?
    private var picker = UIPickerView()
    private var pickerValues = [PickerValue]()
    private var pickerLoaded = false
    private var isUICustomized = false
    fileprivate var temporarySelectedItem = ""
    fileprivate let DONE_BUTTON = 1
    fileprivate let CANCEL_BUTTON = 2
    
    static var NIB_NAME = "FormPickerTableViewCell"
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        hasError(false, message: nil)
        valueTextField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - hasError: <#hasError description#>
    ///   - message: <#message description#>
    fileprivate func hasError(_ hasError: Bool, message: String?) {
        errorLabel.alpha = hasError ? 0 : 1
        if let _message = message {
            errorLabel.text = _message
            errorLabel.sizeToFit()
            valueTextField.borderColor = formItem?.getUIProperties().getErrorColor() ?? .red
        } else {
            errorLabel.text = ""
            errorLabel.sizeToFit()
            valueTextField.borderColor = formItem?.getUIProperties().getTextfieldProperty()?.getBorderColor() ?? .black
        }
    }
    
    ///
    fileprivate func preparePickerView() {
        
        valueTextField.inputView = picker
        valueTextField.inputAccessoryView = getPickerviewToolbar()
        valueTextField.delegate = self
        
        picker.delegate = self
        picker.dataSource = self
        
    }
    
    fileprivate func getPickerviewToolbar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: self.formItem?.getPickerProperties().getPickerDoneButtonTitle() ?? "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(closePicker(sender:)))
        doneButton.tag = DONE_BUTTON
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: self.formItem?.getPickerProperties().getPickerCancelButtonTitle() ?? "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(closePicker(sender:)))
        cancelButton.tag = CANCEL_BUTTON
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    /// Prepare picker view data
    private func loadPickerData() {
        if let values = self.formItem?.getPickerValues() {
            pickerValues = values
        } else {
            pickerValues = [PickerValue(title: "Nessun valore", value: "")]
        }
    }
    
    /// <#Description#>
    /// - Parameter sender: <#sender description#>
    @objc func closePicker(sender:UIBarButtonItem) {
        if( sender.tag == DONE_BUTTON ) {
            valueTextField.text = temporarySelectedItem
            temporarySelectedItem = ""
        }
        
        self.endEditing(true)
    }

    /// <#Description#>
    /// - Parameter textField: <#textField description#>
    @objc public func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, let picker = pickerValues.first(where: { $0.title == text }) {
            self.formItem = self.formItem?.value(picker.value)
        }
    }
}

// MARK: - FormUpdatable
extension FormPickerTableViewCell: FormUpdatable {
    
    public func update(with formItem: FormItem) {
        self.formItem = formItem
        
        if let formItem = self.formItem {
            if let val = formItem.getValue() as? String {
                for picker in pickerValues {
                    if( picker.value == val ) {
                        valueTextField.text = picker.title
                    }
                }
            } else {
                valueTextField.text = ""
            }
            
            if let fieldname = formItem.getTitle() {
                titleLabel.text = fieldname + (formItem.getMandatory() ? "*" : "")
            }
            
            hasError(formItem.getIsValid(), message: formItem.getFormItemErrorMessage())
            
            if( !pickerLoaded ) {
                preparePickerView()
                loadPickerData()
                pickerLoaded = true
            }
            
            if( !isUICustomized ) {
                // Configure textfield UI properties
                
                valueTextField.attributedPlaceholder = NSAttributedString(
                    string: formItem.getPlaceholder() ?? "",
                    attributes: [NSAttributedString.Key.foregroundColor: formItem.getUIProperties().getTextfieldProperty()?.getPlaceholderColor() ?? UIColor.VetryaColor.lightGrey]
                )
                
                valueTextField.keyboardType = formItem.getUIProperties().getKeyboardType()
                valueTextField.tintColor = formItem.getUIProperties().getTintColor()
                
                if let textfieldProperty = formItem.getUIProperties().getTextfieldProperty() {
                    valueTextField.isEnabled = textfieldProperty.getIsActive()
                    
                    if let rightIcon = textfieldProperty.getRightIcon() {
                        valueTextField.setRightIcon(rightIcon, size: nil)
                    }
                    
                    valueTextField.borderColor = textfieldProperty.getBorderColor()
                    valueTextField.border = textfieldProperty.getBorderWidth()
                    
                    if( textfieldProperty.getCornerRadius() > .zero ) {
                        valueTextField.rounded = true
                        valueTextField.roundedRadius = textfieldProperty.getCornerRadius() > valueTextField.frame.size.height/2 ? valueTextField.frame.size.height/2 : textfieldProperty.getCornerRadius()
                    } else {
                        valueTextField.rounded = false
                    }
                    
                    let leftPadding = textfieldProperty.getLeftPadding() > valueTextField.frame.size.width/2 ? valueTextField.frame.size.width/2 : textfieldProperty.getLeftPadding()
                    valueTextField.setLeftPaddingPoints( leftPadding )
                    
                    valueTextField.backgroundColor = textfieldProperty.getBackgroundColor()
                    
                }
                
                isUICustomized = true
            }
        }
    }
    
}

extension FormPickerTableViewCell: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // In textifle that has delegate as self, is not possibile to write text (sex and date textfield)
        return false
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}


extension FormPickerTableViewCell: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerValues[row].title
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        valueTextField.text = pickerValues[row].title
        temporarySelectedItem = pickerValues[row].title
    }
}

extension FormPickerTableViewCell: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }
}
