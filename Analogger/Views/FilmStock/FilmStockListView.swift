//
//  CameraListView.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI
import CoreData

struct FilmStockListView : View {

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \FilmStock.make, ascending: true),
            NSSortDescriptor(keyPath: \FilmStock.type, ascending: true)
        ],
        animation: .default)
    private var filmStocks: FetchedResults<FilmStock>

    @State private var showingItemAddView: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                List() {
                    
                    Section()
                    {
                        
                        ForEach(filmStocks) { filmStock in
                        
                                NavigationLink(destination: FilmStockEditView(filmStock: filmStock))
                            { ListCell(main: filmStock.make, sub: "\(filmStock.type) (\(filmStock.asa) asa)") }
                        }
                            .onDelete(perform: self.delete)
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

    private func delete(offsets: IndexSet) {
        withAnimation {
            offsets.map { filmStocks[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
