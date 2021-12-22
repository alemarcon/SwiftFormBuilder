//
//  FormItemPickerProperties.swift
//  SwiftFormBuilder
//
//  Created by Alessandro Marcon on 14/05/2021.
//

import Foundation

public class FormItemPickerProperties {
    
    //MARK: - Properties
    /// Done button label on accessory view for picker field
    private var pickerDoneButtonTitle: String = "Done"
    /// Cancel button label on accessory view for picker field
    private var pickerCancelButtonTitle: String = "Cancel"
    /// TRUE to avoid entering dates younger than 18 years old. FALSE if all dates are accepted
    private var avoidLegalAge: Bool = false
    /// TRUE to customize avoided dates. Call avoidBefore function and set years, months and days value
    private var customAvoid: Bool = false
    /// Number of years to be avoided
    private var maxYears: Int = 0
    /// Number of months to be avoided
    private var maxMonths: Int = 0
    /// Number of dayss to be avoided
    private var maxDays: Int = 0
    
    
    //MARK: - Init
    public init(doneButtonTitle: String, cancelButtonTitle: String) {
        self.pickerDoneButtonTitle = doneButtonTitle
        self.pickerCancelButtonTitle = cancelButtonTitle
    }
    
    //MARK: - Getter and Setter
    /// Set cancel button label for picker accessory view. Other form item will ignor this property
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public func pickerCancelButtonTitle(_ value: String) -> FormItemPickerProperties {
        self.pickerCancelButtonTitle = value
        return self
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    public func getPickerCancelButtonTitle() -> String {
        return self.pickerCancelButtonTitle
    }
    
    /// Set done button label for picker accessory view. Other form item will ignor this property
    /// - Parameter value: String object contains done button value
    /// - Returns: Current element
    public func pickerDoneButtonTitle(_ value: String) -> FormItemPickerProperties {
        self.pickerDoneButtonTitle = value
        return self
    }
    
    /// Get picker done button label string
    /// - Returns: String rappresent the value of done button picker
    public func getPickerDoneButtonTitle() -> String {
        return self.pickerDoneButtonTitle
    }
    
    /// Check if date picker must show only legal age date. Avoid date younger thans 18 years from today. If voidBefore function will be called, legal age will be override
    /// - Parameter value: TRUE to avoid date younger than 18 years FALSE otherwise
    /// - Returns:
    public func avoidLegalAge(_ value: Bool) -> FormItemPickerProperties {
        self.avoidLegalAge = value
        return self
    }
    
    /// Get legal age void parameter
    /// - Returns:TRUE for avoid younger than legal age, FALSE otherwise
    public func isLegalAgeAvoid() -> Bool {
        return self.avoidLegalAge
    }
    
    /// Customize date avoiding on date picker form item. Other form iterm will ignore this value if setted up. isLegalAgeAvoid will be override if called with custom avoid.
    /// - Parameters:
    ///   - years: Int indicate number of years to avoid. Positive for future years, negative for past years
    ///   - months: Int indicate number of months to avoid. In case of negative number, it will be replaced with absolute value
    ///   - days: Int indicate number of days to avoid. In case of negative number, it will be replaced with absolute value
    /// - Returns:
    public func avoidBefore(years: Int, months: Int, days: Int) -> FormItemPickerProperties {
        self.maxYears = years
        if( months > 12 ) {
            self.maxMonths = 12
        } else {
            self.maxMonths = abs(months)
        }
        if( days > 31 ) {
            self.maxDays = 31
        } else {
            self.maxDays = abs(days)
        }
        self.customAvoid = true
        self.avoidLegalAge = false
        
        return self
    }
    
    /// Number of years to avoid in custom date picker
    /// - Returns: Int rappresent number of years
    public func getYears() -> Int {
        return self.maxYears
    }
    
    /// Number of months to avoid in custom date picker
    /// - Returns: Int rappresent number of months
    public func getMonths() -> Int {
        return self.maxMonths
    }
    
    /// Number of days to avoid in custom date picker
    /// - Returns: Int rappresent number of days
    public func getDays() -> Int {
        return self.maxDays
    }
    
    /// Check if picker must implement custom void date
    /// - Returns: TRUE if date picker must implement custom avoid date. FALSE otherwise
    public func isCustomAvoid() -> Bool {
        return self.customAvoid
    }
}
