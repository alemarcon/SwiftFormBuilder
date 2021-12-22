//
//  FormBuilder.swift
//  SwiftFormBuilder
//
//  Created by Alessandro Marcon on 14/05/2021.
//

import Foundation
import UIKit

public protocol FormBuilderDelegate {
    func formItemsValidationSuccess(items: [ValidatedItem])
}

public class FormBuilder: NSObject {
    
    private var formItems: [FormItem]?
    private var title: String?
    private var table: UITableView?
    
    public var delegate: FormBuilderDelegate?
    
    //MARK: - Form items method
    
    /// Set form items element to show
    /// - Parameter formItems: Array of FormItem Object
    public func set(items formItems: [FormItem]) {
        self.formItems = formItems
    }
    
    /// Add a single FormItem element
    /// - Parameter formItem: FormItem object
    public func add(item formItem: FormItem) {
        self.formItems?.append(formItem)
    }
    
    //MARK: - Loader method
    
    /// Load the array of FormItem objects
    /// - Parameter table: UITableView object to load elements to
    public func loadData(on table: UITableView) {
        if( self.table == nil ) {
            self.table = table
            prepareSubViews()
            self.table?.dataSource = self
        }
        self.table?.reloadData()
    }
    
    //MARK: - Private func
    private func prepareSubViews() {
        if let table = self.table {
            FormItemCellType.registerCells(for: table)
            table.allowsSelection = false
            table.estimatedRowHeight = 60
            table.rowHeight = UITableView.automaticDimension
        }
    }
    
    //MARK: - Form Validation
    @discardableResult
    func isValid() -> (Bool, String?) {
        var isValid = true
        
        if let items = formItems {
            for item in items {
                item.checkValidity()
                if !item.getIsValid() {
                    isValid = false
                }
            }
            return (isValid, nil)
        } else {
            return (false, "No items found!")
        }
    }
    
}
//MARK: - FormValidatorDelegate
extension FormBuilder: FormValidatorDelegate {
    
    public func validationButtonDidPressed() {
        
        if let items = formItems {
            let valid = isValid()
            if( !valid.0 ) {
                self.table?.reloadData()
            } else {
                let validatedItems = ItemMapper().mapArray(of: items)
                delegate?.formItemsValidationSuccess(items: validatedItems)
            }
        }
    }
    
    public func checkboxDidPressed(for item: String, isSelected: Bool) {
        if let items = formItems {
            for currentItem in items {
                if( currentItem.getItemName() == item ) {
                    if let actions = currentItem.getActionItems() {
                        for act in actions {
                            for itemToAct in items {
                                if( itemToAct.getItemName() == act.getItemName() ) {
                                    switch act.getAction() {
                                    case .editing:
                                        _ = itemToAct.getUIProperties().getTextfieldProperty()?.isActive(isSelected)
                                        if( !isSelected ) {
                                            _ = itemToAct.value("")
                                        }
                                    case .visibility:
                                        Logger.print(level: .warning, "No operation for visibility actions")
                                    }
                                }
                            }
                        }
                    }
                }
            }
            self.table?.reloadData()
        }
    }
    
}

//MARK: - Table View Datasource
extension FormBuilder: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.formItems?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if let itmes = self.formItems {
            if let cellType = itmes[indexPath.row].getUIProperties().getCellType() {
                cell = cellType.dequeueCell(for: tableView, at: indexPath)
            } else {
                cell = UITableViewCell()
            }
            
            if let formUpdatableCell = cell as? FormUpdatable {
                let _ = itmes[indexPath.row].indexPath( indexPath )
                formUpdatableCell.update(with: itmes[indexPath.row])
            }
            
            if var formValidator = cell as? FormValidator {
                formValidator.delegate = self
            }
        } else {
            cell = UITableViewCell()
        }
        
        return cell
    }
    
}
