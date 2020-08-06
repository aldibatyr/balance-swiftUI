//
//  MainViewViewModel.swift
//  balance
//
//  Created by Aldiyar Batyrbekov on 7/4/20.
//  Copyright © 2020 Aldiyar Batyrbekov. All rights reserved.
//

import Foundation

class MainViewViewModel: ObservableObject {
    @Published var entries: [Entry]
    
    var balance: Double {
        self.entries.reduce(0, { x, y in
            x + (y.amount)
        })
    }
    
    var totalIncome: Double {
        self.entries.filter { $0.amount > 0 }.reduce(0, { x, y in
            x + y.amount
        })
    }
    
    var totalExpense: Double {
        self.entries.filter { $0.amount < 0 }.reduce(0, { x, y in
            x + y.amount
        })
    }
    
    var allEntries: [Entry] {
        self.entries
    }
    
    var incomeEntries: [Entry] {
        self.entries.filter { $0.amount > 0 }
    }
    
    var expenseEntries: [Entry] {
        self.entries.filter { $0.amount < 0 }
    }
    
    var chartData: [Double] {
        var finalArray: [Double] = []
        let dataArray = self.entries.sorted(by: { lhs, rhs in
            lhs.transactionDate < rhs.transactionDate
        })
        for index in 0..<dataArray.count {
            if index == 0 {
                finalArray.append(dataArray[index].amount)
            } else {
                let sum = finalArray.last! + dataArray[index].amount
                finalArray.append(sum)
            }
        }
        return finalArray
    }
    
    init() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(Double(7400) + (-12.97))
        if let data = try? Data(contentsOf: paths[0].appendingPathComponent("expenses.json")) {
            if let decoded = try? JSONDecoder().decode([Entry].self, from: data) {
                self.entries = decoded
                return
            }
        }
        self.entries = []
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(entries) {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let url = paths[0].appendingPathComponent("expenses.json")
            do {
                try encoded.write(to: url)
            } catch {
                print(error.localizedDescription)
                fatalError()
            }
        }
    }
    
    func add(entry: Entry) {
        entries.append(entry)
        save()
    }
    
    func clear() {
        entries.removeAll()
        save()
    }
    
    func update(entry: Entry) {
        if let index = entries.firstIndex(where: {$0.id == entry.id}) {
            entries[index] = entry
            save()
        } else {
            print("Error occured when looking for an item")
        }
        
    }
}
