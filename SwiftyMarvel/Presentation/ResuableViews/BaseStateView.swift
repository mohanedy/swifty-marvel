//
//  BaseStateView.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 10/07/2023.
//

import SwiftUI

/// Handle changes in the state of the given [ViewModel] and display the appropriate view.
struct BaseStateView<VM, SuccessView, NoItemsView, ErrorView, LoadingView>: View
where VM: ViewModel, SuccessView: View, NoItemsView: View, ErrorView: View,
      LoadingView: View {
    
    @ObservedObject var viewModel: VM
    let successView: () -> SuccessView
    let emptyView: () -> NoItemsView
    let errorView: (String) -> ErrorView
    let loadingView: () -> LoadingView
    
    /// Initialize the view with the given [ViewModel] and views to display in each state.
    ///
    /// - Parameters:
    ///  - viewModel: The [ViewModel] to observe its state.
    ///  - successView: The view to display when the state is [ViewState.success].
    ///  - emptyView: The view to display when the state is [ViewState.empty].
    ///  - errorView: The view to display when the state is [ViewState.error].
    ///  - loadingView: The view to display when the state is [ViewState.loading].
    ///
    ///  - Note: The default value for each view is nil, so you have to provide at least the successView.
    init(viewModel: VM,
         @ViewBuilder successView: @escaping () -> SuccessView,
         @ViewBuilder emptyView: @escaping () -> NoItemsView 
         = { MessageView(message: "noDataFound".localized()) },
         @ViewBuilder errorView: @escaping (String) -> ErrorView 
         = {MessageView(message: $0)},
         @ViewBuilder loadingView: @escaping () -> LoadingView 
         = { ProgressView() }) {
        self.viewModel = viewModel
        self.successView = successView
        self.emptyView = emptyView
        self.errorView = errorView
        self.loadingView = loadingView
    }
    
    var body: some View {
        ZStack {
            successView()
            switch viewModel.state {
            case .initial,
                 .loading:
                loadingView()
            case .error(let errorMessage):
                errorView(errorMessage)
            case .empty:
                emptyView()
            default:
                EmptyView()
            }
        }
    }
}
