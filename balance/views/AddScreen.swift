//
//  AddScreen.swift
//  balance
//
//  Created by Aldiyar Batyrbekov on 7/4/20.
//  Copyright © 2020 Aldiyar Batyrbekov. All rights reserved.
//

import SwiftUI

struct AddScreen: View {
    
    @Environment(\.presentationMode) var pm
    @EnvironmentObject var mainState: MainViewViewModel
    
    @State private var itemName = ""
    @State private var description = ""
    @State private var amount = ""
    @State private var isIncome = false
    @State private var category = Category.unassigned
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Item name", text: $itemName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Description", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Amount", text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                Toggle(isOn: $isIncome, label: {
                    Text("Is this income?")
                })
                if !isIncome {
                    Picker("Category", selection: $category, content: {
                        ForEach(Category.allCases) { category in
                            Text(category.rawValue.capitalized).tag(category)
                        }
                    })
                        .labelsHidden()
                } else {
                    EmptyView()
                }
                Button(action: {
                    self.addEntry()
                }, label: {
                    Text("Save")
                })
            }
            .navigationBarTitle("Add New Entry")
            .navigationBarItems(trailing: Button(action: {
                self.pm.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
                    .padding()
            }))
        }
    }
    
    func addEntry() {
        guard itemName != "" && description != "" && amount != "" else {
            return
        }
        
        var convertedAmount = Double(amount)
        
        if !isIncome {
            convertedAmount = 0 - convertedAmount!
        }
        
        if isIncome {
            category = Category.income
        }
        
        let entry = Entry(id: UUID(), amount: convertedAmount!, title: itemName, description: description, isIncome: isIncome, transactionDate: Date(), category: category)
        mainState.add(entry: entry)
        pm.wrappedValue.dismiss()
    }
}

struct AddScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddScreen()
    }
}
