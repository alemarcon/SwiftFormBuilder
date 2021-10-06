//
//  FormLabelledTableViewCell.swift
//  Supertennis
//
//  Created by Alessandro Marcon on 13/05/2021.
//

import UIKit

class FormLabelledTableViewCell: UITableViewCell, FormConformity {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    //MARK: - Properties
    var formItem: FormItem?
    static var NIB_NAME = "FormLabelledTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
//MARK: - FormUpdatable

extension FormLabelledTableViewCell: FormUpdatable {
    
    func update(with formItem: FormItem) {
        self.formItem = formItem
        
        if let formItem = self.formItem {
            if let val = formItem.getValue() as? String {
                messageLabel.text = val
                messageLabel.sizeToFit()
            } else {
                messageLabel.text = ""
                messageLabel.sizeToFit()
            }
            
            if let size = formItem.getUIProperties().getFontSize() {
                messageLabel.font = messageLabel.font.withSize(size)
            }
            
            if let font = formItem.getUIProperties().getFont() {
                messageLabel.font = font
            }
            
            if let alignment = formItem.getUIProperties().getAlignment() {
                messageLabel.textAlignment = alignment
            }
        }
    }
    
}
