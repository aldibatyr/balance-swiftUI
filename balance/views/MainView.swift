//
//  MainView.swift
//  balance
//
//  Created by Aldiyar Batyrbekov on 7/4/20.
//  Copyright © 2020 Aldiyar Batyrbekov. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var mainState: MainViewViewModel
    @State private var selection = 2
    @State private var addScreenShowing = false
    
    
    var title: Text {
        if selection == 2 {
            return Text("Current Balance")
        } else if selection == 0 {
            return Text("All Income")
        } else {
            return Text("All Expenses")
        }
    }
    
    var totals: Text {
        if selection == 2 {
            return Text("$\(mainState.balance, specifier: "%.2f")")
        } else if selection == 0 {
            return Text("$\(mainState.totalIncome, specifier: "%.2f")")
                .foregroundColor(.green)
        } else {
            return Text("$\(mainState.totalExpense, specifier: "%.2f")")
                .foregroundColor(.red)
        }
    }
    var body: some View {
        NavigationView {
            VStack {
                title
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
                totals
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Picker(selection: $selection, label: Text("List Selection"), content: {
                    Text("All").tag(2)
                    Text("Income").tag(0)
                    Text("Expense").tag(1)
                }).pickerStyle(SegmentedPickerStyle())
                    .padding()
                EntriesList(selection: $selection)
            }
            .navigationBarItems(leading: Button(action: {
                self.mainState.clear()
            }, label: {
                Text("Clear")
            }), trailing: Button(action: {
                self.addScreenShowing = true
            }, label: {
                Image(systemName: "plus")
                    .padding()
            }))
        }
        .sheet(isPresented: $addScreenShowing, content: {
            AddScreen().environmentObject(self.mainState)
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


