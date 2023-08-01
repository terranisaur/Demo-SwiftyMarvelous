//
//  BaseViewModel.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 08/07/2023.
//

import Foundation

@MainActor
public class ViewModel: ObservableObject {
    @Published var state: ViewState = .initial
}

public enum ViewState: Equatable {
    case initial, loading, error(String), success, empty
}
