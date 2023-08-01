//
//  BaseStateView.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 10/07/2023.
//

import SwiftUI

/// Handle changes in the state of the given [ViewModel] and display the appropriate view.
struct BaseStateView<S: View, EM: View, ER: View, L: View>: View {
    @ObservedObject var viewModel: ViewModel
    let successView: S
    let emptyView: EM?
    let createErrorView: (_ errorMessage: String?) -> ER?
    let loadingView: L?
    
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
    init(viewModel: ViewModel,
         successView: S,
         emptyView: EM?,
         createErrorView: @escaping (_ errorMessage: String?) -> ER?,
         loadingView: L) {
        self.viewModel = viewModel
        self.successView = successView
        self.emptyView = emptyView
        self.createErrorView = createErrorView
        self.loadingView = loadingView
    }

    var body: some View {
        ZStack {
            successView
            switch viewModel.state {
            case .initial,
                    .loading:
                loadingView
            case .error(let errorMessage):
                createErrorView(errorMessage)
            case .empty:
                emptyView
            default:
                EmptyView()
            }
        }
    }
}

struct BaseStateDefaultEmptyView: View {
    
    var body: some View {
        MessageView(message: "No Data Found")
    }
}

struct BaseStateDefaultErrorView: View {
    
    var errorMessage: String?
    
    var body: some View {
        MessageView(message: errorMessage ?? "")
    }
}

struct BaseStateDefaultLoadingView: View {
    
    var body: some View {
        ProgressView()
    }
}
