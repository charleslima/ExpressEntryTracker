//
//  PoolDetail.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-04-25.
//

import SwiftUI
import Charts

struct PoolDetail: View {
    
    @State var viewModel: IPoolDetailViewModel
    
    var gradientColor: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.pink.opacity(0.8),
                    Color.pink.opacity(0.01),
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Chart {
                    ForEach(viewModel.poolHistory.history, id: \.date) { mark in
                        LineMark(
                            x: .value("Date", mark.date),
                            y: .value("Candidates", mark.candidates)
                        )
                        .foregroundStyle(Color.pink)
                        .symbol {
                            Circle()
                                .fill(Color.pink)
                                .frame(width: 8)
                        }
                        AreaMark(
                            x: .value("Date", mark.date),
                            y: .value("Candidates", mark.candidates)
                        ).foregroundStyle(gradientColor)
                    }
                }
                .chartXAxis(content: {
                    AxisMarks(values: .stride(by: .month)) { value in
                        AxisTick()
                        AxisGridLine()
                        AxisValueLabel(format: .dateTime.month().year(), centered: false, collisionResolution: AxisValueLabelCollisionResolution.greedy)
                    }
                })
                .frame(height: 300)
                .chartScrollableAxes(.horizontal)
                .padding()
                
                Text("History")
                    .font(.headline)

                VStack(spacing: 12) {
                    ForEach(viewModel.poolHistory.history, id: \.date) { mark in
                        HStack {
                            Text(viewModel.dateString(for: mark.date))
                                .font(.headline)
                            Spacer()
                            Text("\(mark.candidates)")
                                .font(.caption)
                        }
                        Divider()
                    }
                }.padding(.horizontal, 24)
            }
        }
    }
}

#Preview {
    PoolDetail(viewModel: PreviewPoolDetailViewModel())
}
