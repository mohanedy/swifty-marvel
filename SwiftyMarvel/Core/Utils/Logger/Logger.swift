//
//  Logger.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 21/07/2023.
//

import Foundation
import OSLog

extension Logger {
    
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    /// Logs related to the networking.
    static let networking = Logger(subsystem: subsystem, category: "networking")
}
