//
//  FormButtonTableViewCell.swift
//  SwiftFormBuilder
//
//  Created by Alessandro Marcon on 14/05/2021.
//

import UIKit

class FormButtonTableViewCell: UITableViewCell, FormConformity, FormValidator {

    @IBOutlet weak var button: SwiftFormBuilderButton!
    @IBOutlet weak var buttonWidthConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    var formItem: FormItem?
    var delegate: FormValidatorDelegate?
    static var NIB_NAME = "FormButtonTableViewCell"
    private let BUTTON_WIDTH_OFFSET: CGFloat = CGFloat(40)
    fileprivate var isUIConfigured = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func buttonDidPressed(_ sender: UIButton) {
        delegate?.validationButtonDidPressed()
    }
    
}

extension FormButtonTableViewCell: FormUpdatable {
    
    func update(with formItem: FormItem) {
        self.formItem = formItem
        
        button.isEnabled = formItem.getUIProperties().getButtonProperty()?.getIsActive() ?? true
        
        if let formItem = self.formItem {
            
            if( !isUIConfigured ) {
                
                if let title = formItem.getTitle() {
                    button.setTitle(title, for: .normal)
                    if let font = button.titleLabel?.font {
                        let fontAttributes = [NSAttributedString.Key.font: font]
                        let size = (title as NSString).size(withAttributes: fontAttributes)
                        if( (size.width + BUTTON_WIDTH_OFFSET) <= (UIScreen.main.bounds.size.width-BUTTON_WIDTH_OFFSET) ) {
                            buttonWidthConstraint.constant = size.width + BUTTON_WIDTH_OFFSET
                        } else {
                            buttonWidthConstraint.constant = UIScreen.main.bounds.size.width - BUTTON_WIDTH_OFFSET
                        }
                    }
                }
                
                if let buttonProperty = formItem.getUIProperties().getButtonProperty() {
                    if let bgColor = buttonProperty.getBackgroundColor() {
                        button.backgroundColor = bgColor
                    }
                    
                    button.setTitleColor(buttonProperty.getTitleColor(), for: .normal)
                    button.roundedRadius = buttonProperty.getCornerRadius()
                    button.borderColor = buttonProperty.getBorderColor()
                    button.border = buttonProperty.getBorderWidth()
                }
                
                isUIConfigured = true
            }
        }
    }
    
}
