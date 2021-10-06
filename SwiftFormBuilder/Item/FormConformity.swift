//
//  FormConformity.swift
//  Supertennis
//
//  Created by Alessandro Marcon on 12/05/2021.
//

import Foundation

/// Conform receiver to have a form item property
protocol FormConformity {
    var formItem: FormItem? {get set}
}
