//
//  EntriesList.swift
//  balance
//
//  Created by Aldiyar Batyrbekov on 7/5/20.
//  Copyright © 2020 Aldiyar Batyrbekov. All rights reserved.
//

import SwiftUI

struct EntriesList: View {
    @EnvironmentObject var mainState: MainViewViewModel
    @Binding var selection: Int
    var body: some View {
        
        List {
            if selection == 0 {
                ForEach(mainState.incomeEntries) { entry in
                    NavigationLink(destination: EditEntryView(entry: entry)) {
                        EntriesListCell(entry: entry)
                    }
                    
                }
            } else if selection == 1 {
                ForEach(mainState.expenseEntries) { entry in
                    NavigationLink(destination: EditEntryView(entry: entry)) {
                        EntriesListCell(entry: entry)
                    }
                    
                }
            } else {
                ForEach(mainState.allEntries) {
                    entry in
                    NavigationLink(destination: EditEntryView(entry: entry)) {
                        EntriesListCell(entry: entry)
                    }
                }
            }
        }
    }
}

struct EntriesList_Previews: PreviewProvider {
    static var previews: some View {
        EntriesList(selection: .constant(0))
    }
}


