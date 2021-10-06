//
//  FormDateTableViewCell.swift
//  Supertennis
//
//  Created by Alessandro Marcon on 13/05/2021.
//

import UIKit

class FormDateTableViewCell: UITableViewCell, FormConformity {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTextField: VetryaTextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    //MARK: - Cell Properties
    var formItem: FormItem?
    private var datePicker = UIDatePicker()
    private var toolbarLoaded: Bool = false
    private var isUICustomized = false
    static var NIB_NAME = "FormDateTableViewCell"
    
    private let LEGAL_AGE = 18
    private let MAX_PAST_YEARS = 110
    
    private let CANCEL_BAR_BUTTON_ITEM = 1
    private let DONE_BAR_BUTTON_ITEM = 2
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        prepareUI()
        dateTextField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
    }
    
    //MARK: - UI customizations
    
    fileprivate func prepareUI() {
        hasError(false, message: nil)
    }
    
    //MARK: - Picker
    
    /// <#Description#>
    fileprivate func preparePickerView() {
        
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = getPickerviewToolbar()
        dateTextField.delegate = self
        
        if #available(iOS 13.4, *) {
            // Trick for apple bug https://developer.apple.com/forums/thread/651546
            datePicker.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 250.0)
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        datePicker.datePickerMode = .date
        datePicker.maximumDate = configureMaxDateComponents()
        datePicker.minimumDate = configureMinDateComponents()
        
    }
    
    fileprivate func configureMaxDateComponents() -> Date? {
        var maxDate: Date?
        let calendar = Calendar(identifier: .gregorian)
        
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
        if let properties = self.formItem?.getPickerProperties(), properties.isCustomAvoid() == true {
            // Custom avoid date
            components.year = properties.getYears()
            components.month = properties.getMonths()
            components.day = properties.getDays()
            maxDate = calendar.date(byAdding: components, to: currentDate)!
        } else if let legalAge = self.formItem?.getPickerProperties().isLegalAgeAvoid(), legalAge == true {
            // to avoid entering dates younger than 18 years old
            components.year = -LEGAL_AGE
            components.month = 12
            maxDate = calendar.date(byAdding: components, to: currentDate)!
        }
        
        return maxDate
    }
    
    fileprivate func configureMinDateComponents() -> Date? {
        var minDate: Date?
        let calendar = Calendar(identifier: .gregorian)
        
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
        // max 110 years ago
        components.year = -MAX_PAST_YEARS
        minDate = calendar.date(byAdding: components, to: currentDate)!
        
        return minDate
    }
    
    fileprivate func getPickerviewToolbar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: self.formItem?.getPickerProperties().getPickerDoneButtonTitle() ?? "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(closePicker(sender:)))
        doneButton.tag = DONE_BAR_BUTTON_ITEM
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: self.formItem?.getPickerProperties().getPickerCancelButtonTitle() ?? "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(closePicker(sender:)))
        cancelButton.tag = CANCEL_BAR_BUTTON_ITEM
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
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
            dateTextField.borderColor = formItem?.getUIProperties().getErrorColor() ?? .red
        } else {
            errorLabel.text = ""
            errorLabel.sizeToFit()
            dateTextField.borderColor = formItem?.getUIProperties().getTextfieldProperty()?.getBorderColor() ?? .black
        }
    }
    
    /// <#Description#>
    /// - Parameter textField: <#textField description#>
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        self.formItem = self.formItem?.value(textField.text!)
    }
    
    /// <#Description#>
    /// - Parameter sender: <#sender description#>
    @objc func closePicker(sender:UIBarButtonItem) {
        if( sender.tag == DONE_BAR_BUTTON_ITEM ) {
            let dateFormat = DateFormatter()
            dateFormat.locale = Locale.current
            dateFormat.dateFormat = "dd/MM/yyyy"
            dateTextField.text = dateFormat.string(from: datePicker.date)
        }
        
        self.endEditing(true)
    }

}

// MARK: - FormUpdatable
extension FormDateTableViewCell: FormUpdatable {
    
    func update(with formItem: FormItem) {
        self.formItem = formItem
        
        if let formItem = self.formItem {
            if let val = formItem.getValue() as? String {
                dateTextField.text = val
            } else {
                dateTextField.text = ""
            }
            
            if let fieldname = formItem.getTitle() {
                titleLabel.text = fieldname + (formItem.getMandatory() ? "*" : "")
            }
            
            hasError(formItem.getIsValid(), message: formItem.getFormItemErrorMessage())
            
            if( !toolbarLoaded ) {
                preparePickerView()
                toolbarLoaded = true
            }
            
            if( !isUICustomized ) {
                // Configure textfield UI properties
                
                dateTextField.attributedPlaceholder = NSAttributedString(
                    string: formItem.getPlaceholder() ?? "",
                    attributes: [NSAttributedString.Key.foregroundColor: formItem.getUIProperties().getTextfieldProperty()?.getPlaceholderColor() ?? UIColor.VetryaColor.lightGrey]
                )
                
                dateTextField.keyboardType = formItem.getUIProperties().getKeyboardType()
                dateTextField.tintColor = formItem.getUIProperties().getTintColor()
                
                if let textfieldProperty = formItem.getUIProperties().getTextfieldProperty() {
                    dateTextField.isEnabled = textfieldProperty.getIsActive()
                    
                    if let rightIcon = textfieldProperty.getRightIcon() {
                        dateTextField.setRightIcon(rightIcon, size: nil)
                    }
                    
                    dateTextField.borderColor = textfieldProperty.getBorderColor()
                    dateTextField.border = textfieldProperty.getBorderWidth()
                    
                    if( textfieldProperty.getCornerRadius() > .zero ) {
                        dateTextField.rounded = true
                        dateTextField.roundedRadius = textfieldProperty.getCornerRadius() > dateTextField.frame.size.height/2 ? dateTextField.frame.size.height/2 : textfieldProperty.getCornerRadius()
                    } else {
                        dateTextField.rounded = false
                    }
                    
                    let leftPadding = textfieldProperty.getLeftPadding() > dateTextField.frame.size.width/2 ? dateTextField.frame.size.width/2 : textfieldProperty.getLeftPadding()
                    dateTextField.setLeftPaddingPoints( leftPadding )
                    
                    dateTextField.backgroundColor = textfieldProperty.getBackgroundColor()
                    
                }
                
                isUICustomized = true
            }
        }
    }
    
}


extension FormDateTableViewCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // In textifle that has delegate as self, is not possibile to write text (sex and date textfield)
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
