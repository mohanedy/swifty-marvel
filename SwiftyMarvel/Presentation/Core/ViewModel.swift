//
//  BaseViewModel.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import Foundation

class ViewModel {
    @Published var state: ViewState = .initial
}

enum ViewState {
    case initial, loading, error(String), success
}
