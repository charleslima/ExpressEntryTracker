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
        GeometryReader { proxy in
            List {
                Section {
                    switch viewModel.viewMode {
                    case .rounds:
                        rounds(draws: draws, availableScreenHeight: proxy.size.height)
                    case .pool:
                        pool(draws: draws)
                    }
                } header: {
                    viewModePicker
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
            .navigationDestination(for: Draw.self, destination: { draw in
                WebView(url: draw.drawNumberURL)
                    .navigationTitle(draw.drawName)
                    .navigationBarTitleDisplayMode(.inline)
            })
            .navigationDestination(for: ScorePool.self, destination: { pool in
                PoolDetail(viewModel: PoolDetailViewModel(poolHistory: viewModel.history(for: pool.range)))
                    .navigationTitle(pool.range.rawValue)
            })
            .toolbar(content: {
                if viewModel.displayFilter {
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
                }
            })
        }
    }
    
    @ViewBuilder private func loadingState() -> some View {
        ScrollView {
            ForEach((1...10), id: \.self) { id in
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
    
    @ViewBuilder private var viewModePicker: some View {
        Picker("View Mode", selection: $viewModel.viewMode) {
            ForEach(DrawsViewMode.allCases) {
                Text($0.title).tag($0)
                    .textCase(nil)
            }
        }
        .pickerStyle(.segmented)
        .padding(24)
    }
    
    @ViewBuilder private func rounds(draws: [Draw], availableScreenHeight: CGFloat) -> some View {
        ForEach(draws, id: \.drawNumber) { draw in
            ZStack {
                NavigationLink(draw.drawName, value: draw).opacity(0)
                DrawItemView(draw: draw)
                    .visualEffect { content, proxy in
                        let screenPosition = proxy.frame(in: .global).origin.y / availableScreenHeight
                        return content
                            .blur(radius: min(3, max(0, (screenPosition * 10) - 9.5)))
                            .scaleEffect((screenPosition/10)+0.9, anchor: .bottom)
                    }
            }
        }.listRowSeparator(.hidden)
    }
    
    @ViewBuilder private func pool(draws: [Draw]) -> some View {
        if let draw = draws.first {
            Text(viewModel.poolTitle(date: draw.drawDistributionAsOn))
                .multilineTextAlignment(.center)
                .font(.title3)
                .frame(maxWidth: .infinity)
                .padding()
                .listRowSeparator(.hidden)
            ForEach(draw.pool, id: \.range) { pool in
                ZStack {
                    NavigationLink(viewModel.poolTitle(date: draw.drawDistributionAsOn), value: pool).opacity(0)
                    HStack {
                        Text(pool.range.rawValue)
                            .font(.headline)
                        Spacer()
                        Text(pool.candidates)
                            .font(.subheadline)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
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
