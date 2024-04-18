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
    @State private var isRefreshing = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ScrollView {
                    switch  viewModel.state {
                    case .success(let draws):
                        if isRefreshing {
                            ForEach((1...10).reversed(), id: \.self) { id in
                                DrawItemShimmerView()
                            }
                        } else {
                            VStack(spacing: 0) {
                                ForEach(draws, id:  \.drawNumber) { draw in
                                    DrawItemView(draw: draw)
                                }
                            }
                        }
                    case .failure(_):
                        errorState(geo: geo)
                    }
                }
            }
            .refreshable {
                await refresh()
            }
            .navigationTitle("Rounds")
        }
        .task {
            self.isRefreshing.toggle()
            await refresh()
            self.isRefreshing.toggle()
        }
    }
    
    @ViewBuilder private func errorState(geo: GeometryProxy) -> some View {
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
            
        }
        .padding(24)
        .frame(minWidth: geo.size.width,
               minHeight: geo.size.height * 0.7)
    }
    
    private func refresh() async {
        await viewModel.fetchDraws()
    }
}

#Preview {
    DrawsView(viewModel: PreviewDrawsViewModel())
}
