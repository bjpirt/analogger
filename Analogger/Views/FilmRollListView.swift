//
//  FilmRollListView.swift
//  Analogger
//
//  Created by Ben Pirt on 17/09/2024.
//

import SwiftUI
import CoreData

struct FilmRollListView : View {
    
    @StateObject private var dataSource = CoreDataSource<FilmRoll>()
        .sortKeys(sortKey1: "active", sortKey2: "created")
    
    @State private var showingItemAddView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                List() {
                    Section()
                    {
                        
                        ForEach(self.dataSource.objects) { filmRoll in
                        
                                NavigationLink(destination: FilmRollEditView(filmRoll: filmRoll))
                            { FilmRollListCell(name: filmRoll.name) }
                        }
                            .onDelete(perform: self.dataSource.delete)
                    }
                }
                HiddenNavigationLink(destination: FilmRollAddView(), isActive: self.$showingItemAddView)
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Film Rolls"), displayMode: .large)
            .navigationBarItems(trailing:
                HStack {
                ActivateButton(activates: $showingItemAddView) { Image(systemName: "plus") }
                } )
         }
    }
}
