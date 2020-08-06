//
//  ContentView.swift
//  balance
//
//  Created by Aldiyar Batyrbekov on 7/4/20.
//  Copyright © 2020 Aldiyar Batyrbekov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTab = 0
    var body: some View {
        TabView {
            MainView()
            .tabItem({
                VStack {
                    Image(systemName: "house")
                    Text("Home")
                }
            }).tag(0)
            StatsView()
            .tabItem({
                VStack {
                    Image(systemName: "chart.pie")
                    Text("Balance Summary")
                }
                }).tag  (1)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


