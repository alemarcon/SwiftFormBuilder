//
//  ActionItem.swift
//  Supertennis
//
//  Created by Alessandro Marcon on 17/05/2021.
//

import Foundation

public enum ActionType {
    case editing
    case visibility
}

public class ActionItem {
    
    private var itemName: String
    private var action: ActionType
    
    public init(itemName: String, action: ActionType) {
        self.itemName = itemName
        self.action = action
    }
    
    public func getItemName() -> String {
        return itemName
    }
    
    public func getAction() -> ActionType {
        return action
    }
    
}
