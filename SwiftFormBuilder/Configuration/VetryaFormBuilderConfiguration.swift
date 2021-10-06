//
//  VetryaFormBuilderConfiguration.swift
//  VTRFormBuilder
//
//  Created by Alessandro Marcon on 26/05/2021.
//

import Foundation

/// Available Log levels
public enum LogLevel:String {
    /// Print on console all logs
    case warning
    /// Print on console only logs fired in warning cases
    case verbose
}

public class VetryaConf {
    /// Current application loglevel
    private var _logLevel: LogLevel = .verbose
    /// Singleton object for VetryaOAuthConf
    static let shared: VetryaConf = VetryaConf()
    /// Default VetryaOAuthConf initializer
    private init() { }
    
    /// Public var for framework loglevel
    public static var logLevel: LogLevel {
        get {
            return shared._logLevel
        }
        set {
            shared._logLevel = newValue
        }
    }
    
}
