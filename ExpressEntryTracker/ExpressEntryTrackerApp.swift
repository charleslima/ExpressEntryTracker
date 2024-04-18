//
//  ExpressEntryTrackerApp.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-04-17.
//

import SwiftUI

@main
struct ExpressEntryTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            DrawsView(viewModel: DrawsViewModel())
        }
    }
}
