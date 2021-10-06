//
//  FormCheckboxTableViewCell.swift
//  Supertennis
//
//  Created by Alessandro Marcon on 13/05/2021.
//

import UIKit

class FormCheckboxTableViewCell: UITableViewCell, FormConformity, FormValidator {

    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var checkboxLabel: UILabel!
    
    //MARK: - Properties
    var formItem: FormItem?
    var delegate: FormValidatorDelegate?
    static var NIB_NAME = "FormCheckboxTableViewCell"
    
    private var checkOn = UIImage(named: "check_on")
    private var checkOff = UIImage(named: "check_off")
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBAction func checkboxDidTapped(_ sender: UIButton) {
        self.formItem = self.formItem?.value(!sender.isSelected)
        checkboxButton.isSelected = !sender.isSelected
        delegate?.checkboxDidPressed(for: formItem?.getItemName() ?? "", isSelected: checkboxButton.isSelected)
    }
    
}

extension FormCheckboxTableViewCell: FormUpdatable {
    
    func update(with formItem: FormItem) {
        self.formItem = formItem
        
        if let formItem = self.formItem {
            if let val = formItem.getValue() as? Bool {
                checkboxButton.isSelected = val
            } else {
                checkboxButton.isSelected = false
            }
            
            if let fieldname = formItem.getTitle() {
                checkboxLabel.text = fieldname + (formItem.getMandatory() ? "*" : "")
            }
        }
    }
    
}
