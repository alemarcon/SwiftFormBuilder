//
//  FormUpdatable.swift
//  Supertennis
//
//  Created by Alessandro Marcon on 12/05/2021.
//

import Foundation

/// Conform the view receiver to be updated with a form item
public protocol FormUpdatable {
    
    /// Update item
    /// - Parameter formItem: FormItem object to be updated
    func update(with formItem: FormItem)
    
}
