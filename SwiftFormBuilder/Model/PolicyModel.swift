//
//  PolicyModel.swift
//  SwiftFormBuilder
//
//  Created by Alessandro Marcon on 26/05/2021.
//

import Foundation

public struct PolicyModel {
    
    public var itemType: String
    public var id: String
    public var idVersion: String
    public var text: String
    public var isRequired: Bool
    public var link: String
    public var isAccepted: Bool
    public var isInteractive: Bool
    public var initialState: Bool
    public var order: Int
    public var expirationTime: String
    public var isToShow: Bool
    
    public init() {
        itemType = ""
        id = ""
        idVersion = ""
        text = ""
        isRequired = false
        link = ""
        isAccepted = false
        isInteractive = false
        initialState = false
        order = 0
        expirationTime = ""
        isToShow = false
    }
    
}
