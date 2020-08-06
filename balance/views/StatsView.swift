//
//  StatsView.swift
//  balance
//
//  Created by Aldiyar Batyrbekov on 7/5/20.
//  Copyright © 2020 Aldiyar Batyrbekov. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct StatsView: View {
    @EnvironmentObject var mainModel: MainViewViewModel
    var body: some View {
        LineView(data: mainModel.chartData, title: "Current Summary", legend: "Your current balance is $\(mainModel.chartData.last ?? 0.0)")
        .padding()
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
