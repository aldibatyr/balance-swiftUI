//
//  Entry.swift
//  balance
//
//  Created by Aldiyar Batyrbekov on 7/4/20.
//  Copyright © 2020 Aldiyar Batyrbekov. All rights reserved.
//

import Foundation

enum Category: String, Codable, CaseIterable, Hashable, Identifiable {
    case subscription = "subscription"
    case bills = "bills"
    case housing = "housing"
    case transportation = "transportation"
    case food = "food"
    case travel = "travel"
    case tech = "tech"
    case business = "business"
    case unassigned = "unassigned"
    case income = "income"
    
    var id: Category { self }
}

struct Entry: Identifiable, Codable, Comparable {
    static func < (lhs: Entry, rhs: Entry) -> Bool {
        lhs.transactionDate < rhs.transactionDate
    }
    
    var id: UUID
    var amount: Double
    var title: String?
    var description: String?
    var isIncome: Bool?
    var transactionDate: Date
    var category: Category = Category.unassigned
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: transactionDate)
    }

}

extension Entry {
    static let example = Entry(id: UUID(), amount: 299.99, title: "Example Entry", description: "Lorem ipsum", isIncome: true, transactionDate: Date(), category: .tech)
}
