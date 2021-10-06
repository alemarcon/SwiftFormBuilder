//
//  SeparatorTableViewCell.swift
//  Supertennis
//
//  Created by Alessandro Marcon on 18/05/2021.
//

import UIKit

class SeparatorTableViewCell: UITableViewCell, FormConformity {

    @IBOutlet weak var separator: UIView!
    var formItem: FormItem?
    
    static var NIB_NAME = "SeparatorTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension SeparatorTableViewCell: FormUpdatable {
    
    func update(with formItem: FormItem) {
        self.formItem = formItem
        
        if let formItem = self.formItem {
            separator.backgroundColor = formItem.getUIProperties().getNonTextualElementBackgroundColor()
        }
    }
    
}
