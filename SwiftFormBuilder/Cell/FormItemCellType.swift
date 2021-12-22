//
//  FormItemCellType.swift
//  SwiftFormBuilder
//
//  Created by Alessandro Marcon on 12/05/2021.
//

import Foundation
import UIKit

/// UI Cell Type to be displayed
public enum FormItemCellType {
    
    case textfield
    case datePicker
    case valuePicker
    case checkbox
    case link
    case text
    case button
    case separator
    
    /// Registering methods for all forms items cell types
    ///
    /// - Parameter tableView: TableView where apply cells registration
    static func registerCells(for tableView: UITableView) {
        tableView.register(
            UINib(
                nibName: FormTextFieldTableViewCell.NIB_NAME,
                bundle: Bundle(for: FormTextFieldTableViewCell.classForCoder())
            ), forCellReuseIdentifier: FormTextFieldTableViewCell.IDENTIFIER)

        tableView.register(
            UINib(
                nibName: FormDateTableViewCell.NIB_NAME,
                bundle: Bundle(for: FormDateTableViewCell.classForCoder())
            ), forCellReuseIdentifier: FormDateTableViewCell.NIB_NAME)

        tableView.register(
            UINib(
                nibName: FormPickerTableViewCell.NIB_NAME,
                bundle: Bundle(for: FormPickerTableViewCell.classForCoder())
            ), forCellReuseIdentifier: FormPickerTableViewCell.NIB_NAME)

        tableView.register(
            UINib(
                nibName: FormCheckboxTableViewCell.NIB_NAME,
                bundle: Bundle(for: FormCheckboxTableViewCell.classForCoder())
            ), forCellReuseIdentifier: FormCheckboxTableViewCell.NIB_NAME)

        tableView.register(
            UINib(
                nibName: FormTappableLinkTableViewCell.NIB_NAME,
                bundle: Bundle(for: FormTappableLinkTableViewCell.classForCoder())
            ), forCellReuseIdentifier: FormTappableLinkTableViewCell.NIB_NAME)

        tableView.register(
            UINib(
                nibName: FormLabelledTableViewCell.NIB_NAME,
                bundle: Bundle(for: FormLabelledTableViewCell.classForCoder())
            ), forCellReuseIdentifier: FormLabelledTableViewCell.NIB_NAME)

        tableView.register(
            UINib(nibName: FormButtonTableViewCell.NIB_NAME,
                  bundle: Bundle(for: FormButtonTableViewCell.classForCoder())
            ), forCellReuseIdentifier: FormButtonTableViewCell.NIB_NAME)
        
        tableView.register(
            UINib(nibName: SeparatorTableViewCell.NIB_NAME,
                  bundle: Bundle(for: SeparatorTableViewCell.classForCoder())
            ), forCellReuseIdentifier: SeparatorTableViewCell.NIB_NAME)
        
        
    }
    
    /// Correctly dequeue the UITableViewCell according to the current cell type
    ///
    /// - Parameters:
    ///   - tableView: TableView where cells previously registered
    ///   - indexPath: indexPath where dequeue
    /// - Returns: a non-nullable UITableViewCell dequeued
    func dequeueCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        switch self {
        case .textfield:
            cell = tableView.dequeueReusableCell(withIdentifier: FormTextFieldTableViewCell.IDENTIFIER, for: indexPath)
        case .datePicker:
            cell = tableView.dequeueReusableCell(withIdentifier: FormDateTableViewCell.NIB_NAME, for: indexPath)
        case .valuePicker:
            cell = tableView.dequeueReusableCell(withIdentifier: FormPickerTableViewCell.NIB_NAME, for: indexPath)
        case .checkbox:
            cell = tableView.dequeueReusableCell(withIdentifier: FormCheckboxTableViewCell.NIB_NAME, for: indexPath)
        case .link:
            cell = tableView.dequeueReusableCell(withIdentifier: FormTappableLinkTableViewCell.NIB_NAME, for: indexPath)
        case .text:
            cell = tableView.dequeueReusableCell(withIdentifier: FormLabelledTableViewCell.NIB_NAME, for: indexPath)
        case .button:
            cell = tableView.dequeueReusableCell(withIdentifier: FormButtonTableViewCell.NIB_NAME, for: indexPath)
        case .separator:
            cell = tableView.dequeueReusableCell(withIdentifier: SeparatorTableViewCell.NIB_NAME, for: indexPath)
        }
        
        return cell
    }
}
