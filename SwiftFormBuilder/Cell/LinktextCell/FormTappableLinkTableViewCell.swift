//
//  FormTappableLinkTableViewCell.swift
//  SwiftFormBuilder
//
//  Created by Alessandro Marcon on 13/05/2021.
//

import UIKit

class FormTappableLinkTableViewCell: UITableViewCell, FormConformity {
    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    //MARK: - Properties
    var formItem: FormItem?
    static var NIB_NAME = "FormTappableLinkTableViewCell"
    
    private var checkOn = UIImage(named: "check_on", in: Bundle(for: FormTappableLinkTableViewCell.classForCoder()), compatibleWith: nil)
    private var checkOff = UIImage(named: "check_off", in: Bundle(for: FormTappableLinkTableViewCell.classForCoder()), compatibleWith: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapLinkAction = UITapGestureRecognizer(target: self, action: #selector(openUrlInExternalBrowser))
        linkLabel.isUserInteractionEnabled = true
        linkLabel.addGestureRecognizer(tapLinkAction)
        hasError(false, message: nil)
        
        checkboxButton.setImage(checkOff, for: .normal)
        checkboxButton.setImage(checkOn, for: .selected)
        checkboxButton.isSelected = false
    }
    
    fileprivate func hasError(_ hasError: Bool, message: String?) {
        errorMessageLabel.alpha = hasError ? 0 : 1
        if let _message = message {
            errorMessageLabel.text = _message
            errorMessageLabel.sizeToFit()
        } else {
            errorMessageLabel.text = ""
            errorMessageLabel.sizeToFit()
        }
    }
    
    @IBAction func checkboxDidTapped(_ sender: UIButton) {
        self.formItem = self.formItem?.value(!sender.isSelected)
        checkboxButton.isSelected = !sender.isSelected
    }
    
    @objc func openUrlInExternalBrowser() {
        if let url = formItem?.getLink() {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension FormTappableLinkTableViewCell: FormUpdatable {
    
    func update(with formItem: FormItem) {
        self.formItem = formItem
        
        if let formItem = self.formItem {
            if let val = formItem.getValue() as? Bool {
                checkboxButton.isSelected = val
            } else {
                checkboxButton.isSelected = false
            }
            
            hasError(formItem.getIsValid(), message: formItem.getFormItemErrorMessage())
            if var linkName = formItem.getTitle() {
                linkName = linkName + (formItem.getMandatory() ? "*" : "")
                
                let underlined = formItem.getUnderlinedPartTitle() ?? linkName
                let attributedString = StringUtils.getAttributedString(
                    phrase: linkName,
                    phraseFont: linkLabel.font,
                    phraseColor: formItem.getUIProperties().getTextColor(),
                    words: [underlined],
                    wordsFont: linkLabel.font,
                    wordsColor: formItem.getUIProperties().getUnderlinedTextColor(),
                    wordsKey: [
                        .underlineStyle:NSUnderlineStyle.single.rawValue
                    ]
                )
                
                linkLabel.attributedText = attributedString
                linkLabel.sizeToFit()
            }
        }
    }
    
}
