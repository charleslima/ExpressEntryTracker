//
//  ViewState.swift
//  Utilities
//
//  Created by Charles Lima on 2024-04-18.
//

import Foundation

public enum ViewState<T> {
    case loading
    case loaded(T)
    case error(Error)
}
