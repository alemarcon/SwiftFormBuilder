//
//  ItemMapper.swift
//  Supertennis
//
//  Created by Alessandro Marcon on 17/05/2021.
//

import Foundation

public class ItemMapper {
    
    /// Map single FormItem object in singole ValidateItem object. Used after check validation
    /// - Parameter item: The item to map
    /// - Returns: ValidatedItem mapped depending on FormItem object
    public func map(item: FormItem) -> ValidatedItem {
        return ValidatedItem(name: item.getItemName(), value: item.getValue() ?? "")
    }
    
    /// <#Description#>
    /// - Parameter items: <#items description#>
    /// - Returns: <#description#>
    public func mapArray(of items: [FormItem]) -> [ValidatedItem] {
        var validated = [ValidatedItem]()
        for item in items {
            validated.append( map(item: item) )
        }
        return validated
    }
    
}
