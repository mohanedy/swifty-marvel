//
//  BaseStateView.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 10/07/2023.
//

import SwiftUI

struct BaseStateView: View {
    @ObservedObject var viewModel: ViewModel
    let successView: AnyView
    let emptyView: AnyView?
    let errorView: AnyView?
    let loadingView: AnyView?

    init(viewModel: ViewModel,
         successView: AnyView,
         emptyView: AnyView? = nil,
         errorView: AnyView? = nil,
         loadingView: AnyView? = nil) {
        self.viewModel = viewModel
        self.successView = successView
        self.emptyView = emptyView
        self.errorView = errorView
        self.loadingView = loadingView
    }
    
    var body: some View {
        ZStack {
            successView
            switch viewModel.state {
            case .initial,
                    .loading:
                loadingView ?? AnyView(ProgressView())
            case .error(let errorMessage):
                errorView ?? AnyView(MessageView(message: errorMessage))
            case .empty:
                emptyView ?? AnyView(MessageView(message: "No Data Found"))
            default:
                EmptyView()
            }
        }
    }
}
