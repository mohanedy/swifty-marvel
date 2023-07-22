//
//  String+Localization.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 22/07/2023.
//

import Foundation

extension String {
    /// Localizes the string using the `Localizable.strings` file.
    func localized(with comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
