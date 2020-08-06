//
//  EntriesListCell.swift
//  balance
//
//  Created by Aldiyar Batyrbekov on 7/5/20.
//  Copyright © 2020 Aldiyar Batyrbekov. All rights reserved.
//

import SwiftUI

struct EntriesListCell: View {
    let entry: Entry
    var color: Color {
        switch entry.category {
        case .bills:
            return Color.yellow
        case .business:
            return Color.blue
        case .food:
            return Color.orange
        case .housing:
            return Color.red
        case .income:
            return Color.green
        case .subscription:
            return Color.purple
        case .tech:
            return Color.pink
        case .transportation:
            return Color.gray
        case .travel:
            return Color.accentColor
        case .unassigned:
            return Color.secondary
        }
    }
    var body: some View {
        HStack(alignment: .top) {
            HStack(alignment: .center) {
                Circle()
                    .frame(width: 16, height: 16)
                    .foregroundColor(color)
                VStack(alignment: .leading) {
                    Text(entry.title ?? "Unavailable")
                        .font(.callout)
                    Text("$\(entry.amount, specifier: "%.2f")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            Text(entry.formattedDate)
                .font(.callout)
        }
    }
}

struct EntriesListCell_Previews: PreviewProvider {
    static var previews: some View {
        EntriesListCell(entry: Entry.example)
    }
}
