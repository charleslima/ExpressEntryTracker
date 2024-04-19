//
//  ContentView.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-04-17.
//

import SwiftUI
import DesignSystem
import WebKit

struct DrawsView: View {
    @State var viewModel: IDrawsViewModel
    
    var body: some View {
        NavigationStack {
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
        List(draws, id: \.drawNumber) { draw in
            ZStack {
                NavigationLink(draw.drawName, value: draw).opacity(0)
                DrawItemView(draw: draw)
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationDestination(for: Draw.self, destination: { draw in
            WebView(url: draw.drawNumberURL)
                .navigationTitle(draw.drawName)
                .navigationBarTitleDisplayMode(.inline)
        })
        .toolbar(content: {
            Menu {
                Button(action: {
                    self.viewModel.filter = nil
                }, label: {
                    HStack {
                        Image(systemName: "xmark.circle")
                        Text("Clear Filter")
                    }
                })
                Picker("Filter", selection: $viewModel.filter) {
                    ForEach(viewModel.filterOptions, id: \.self) {
                        if let option = $0 {
                            Text(option).tag(option as String?)
                        }
                    }
                }
            } label: {
                Image(systemName: viewModel.filter != nil ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
            }
        })
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
