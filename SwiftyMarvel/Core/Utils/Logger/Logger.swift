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
    
    /// Logs related to local data source errors and debugging
    static let localDataSource = Logger(subsystem: subsystem, category: "local data source")
}
