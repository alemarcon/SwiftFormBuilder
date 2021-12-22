//
//  DependenceItem.swift
//  SwiftFormBuilder
//
//  Created by Alessandro Marcon on 17/05/2021.
//

import Foundation

public enum DependencyType {
    case equal
    case fill
}


public class DependenceItem {
    
    private var dependence: FormItem
    private var type: DependencyType
    
    public init(item: FormItem, dependency type: DependencyType) {
        self.dependence = item
        self.type = type
    }
    
    public func getType() -> DependencyType {
        return type
    }
    
    public func getDependencyItem() -> FormItem {
        return self.dependence
    }
    
}
