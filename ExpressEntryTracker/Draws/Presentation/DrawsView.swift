//
//  ContentView.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-04-17.
//

import SwiftUI
import DesignSystem

struct DrawsView: View {
    
    @State var viewModel: IDrawsViewModel
    
    var body: some View {
        NavigationView {
            
            switch viewModel.state {
            case .loading:
                loadingState()
                    .navigationTitle("Rounds")
            case .loaded(let draws):
                loadedState(draws: draws)
                    .navigationTitle("Rounds")
                    .refreshable {
                        await refresh()
                    }
            case .error:
                errorState()
            }
        }
        .task {
            await viewModel.fetch()
        }
    }
    
    @ViewBuilder private func loadedState(draws: [Draw]) -> some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(draws, id:  \.drawNumber) { draw in
                    DrawItemView(draw: draw)
                }
            }
        }
    }
    
    @ViewBuilder private func loadingState() -> some View {
        ScrollView {
            ForEach((1...10).reversed(), id: \.self) { id in
                DrawItemShimmerView()
            }
        }
    }
        
    @ViewBuilder private func errorState() -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.warninglight")
                .font(.system(size: 44))
                .foregroundStyle(.quaternary)
            Text("Oops! Something Went Wrong")
                .font(.headline)
                .foregroundStyle(.secondary)
            Text("We're sorry, but an unexpected error occurred. Please try again later")
                .font(.subheadline)
                .foregroundStyle(.tertiary)
                .multilineTextAlignment(.center)
            Button("Retry") {
                Task {
                    await viewModel.fetch()
                }
            }.buttonStyle(.borderedProminent)
                .font(.headline)
            
        }
        .padding(24)
    }
    
    private func refresh() async {
        await viewModel.refresh()
    }
}

#Preview("Loaded State") {
    DrawsView(viewModel: PreviewDrawsViewModel(state: .loaded(PreviewDrawsViewModel.draws)))
}

#Preview("Error State") {
    DrawsView(viewModel: PreviewDrawsViewModel(state: .error(NSError())))
}

#Preview("Loading State") {
    DrawsView(viewModel: PreviewDrawsViewModel(state: .loading))
}
