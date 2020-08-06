//
//  EditEntryView.swift
//  balance
//
//  Created by Aldiyar Batyrbekov on 8/5/20.
//  Copyright © 2020 Aldiyar Batyrbekov. All rights reserved.
//

import SwiftUI

struct EditEntryView: View {
    @Environment(\.presentationMode) var pm
    @EnvironmentObject var viewModel: MainViewViewModel
    let entry: Entry
    
    @State private var itemName = ""
    @State private var description = ""
    @State private var amount = ""
    @State private var isIncome = false
    @State private var category = Category.unassigned
    var body: some View {
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
                self.updateEntry()
            }, label: {
                Text("Save")
            })
        }
        .navigationBarTitle("Edit Entry")
        .onAppear(perform: {
            self.itemName = self.entry.title ?? "Unknown"
            self.description = self.entry.description ?? "Unknown"
            self.amount = String(self.entry.amount)
            self.isIncome = self.entry.isIncome ?? false
            self.category = self.entry.category
        })
    }
    
    func updateEntry() {
        
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
        
        var copyOfEntry = entry
        copyOfEntry.title = itemName
        copyOfEntry.description = description
        copyOfEntry.amount = convertedAmount!
        copyOfEntry.isIncome = isIncome
        copyOfEntry.category = category
        print(viewModel.entries)
        print(copyOfEntry)
        viewModel.update(entry: copyOfEntry)
        self.pm.wrappedValue.dismiss()
    }
}

struct EditEntryView_Previews: PreviewProvider {
    static var previews: some View {
        EditEntryView(entry: Entry.example)
    }
}
