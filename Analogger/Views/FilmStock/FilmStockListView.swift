//
//  CameraListView.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI
import CoreData

struct FilmStockListView : View {

    @StateObject private var dataSource = CoreDataSource<FilmStock>()
        .sortKeys(sortKey1: "make", sortKey2: "type")

    @State private var showingItemAddView: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                List() {
                    
                    Section()
                    {
                        
                        ForEach(self.dataSource.objects) { filmStock in
                        
                                NavigationLink(destination: FilmStockEditView(filmStock: filmStock))
                            { ListCell(main: filmStock.make, sub: "\(filmStock.type) (\(filmStock.asa) asa)") }
                        }
                            .onDelete(perform: self.dataSource.delete)
                    }
                }
                HiddenNavigationLink(destination: FilmStockAddView(), isActive: self.$showingItemAddView)
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Film Stock"), displayMode: .large)
            .navigationBarItems(trailing:
                HStack {
                ActivateButton(activates: $showingItemAddView) { Image(systemName: "plus") }
                } )
         }
    }
}
