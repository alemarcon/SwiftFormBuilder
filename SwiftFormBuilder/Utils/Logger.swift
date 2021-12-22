//
//  Application.swift
//  SwiftFormBuilder
//
//  Created by Alessandro Marcon on 26/05/2021.
//

import Foundation

class Logger {
    
    static func print(level: LogLevel, _ text: String) {
        switch SwiftFormBuilderConf.logLevel {
        case .verbose:
            Swift.print("[VTRFormBuilder - \(level.rawValue.uppercased())] \(text)")
        case .warning:
            if level == .warning {
                Swift.print("[VTRFormBuilder - \(level.rawValue.uppercased())] \(text)")
            }
        }
    }
    
}
