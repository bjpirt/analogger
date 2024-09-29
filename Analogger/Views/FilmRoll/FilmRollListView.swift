//
//  FilmRollListView.swift
//  Analogger
//
//  Created by Ben Pirt on 17/09/2024.
//

import SwiftUI
import CoreData

struct FilmRollListView : View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FilmRoll.created, ascending: false)],
        animation: .default)
    private var filmRolls: FetchedResults<FilmRoll>
    
    @State private var showingItemAddView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                List() {
                    Section("Active Rolls")
                    {
                        
                        ForEach(filmRolls) { filmRoll in
                            if !filmRoll.complete {
                                NavigationLink(destination: FilmRollView(filmRoll: filmRoll))
                                { FilmRollListCell(filmRoll: filmRoll) }
                            }
                        }
                            .onDelete(perform: self.delete)
                    }
                    Section("Complete Rolls")
                    {
                        ForEach(filmRolls) { filmRoll in
                            if filmRoll.complete {
                                NavigationLink(destination: FilmRollView(filmRoll: filmRoll))
                                { FilmRollListCell(filmRoll: filmRoll) }
                            }
                        }
                            .onDelete(perform: self.delete)
                    }
                }
                HiddenNavigationLink(destination: FilmRollAddView(), isActive: self.$showingItemAddView)
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Film Rolls"), displayMode: .large)
            .navigationBarItems(
                trailing:
                HStack {
                    ActivateButton(activates: $showingItemAddView) { Image(systemName: "plus") }
                }
            )
         }
        .onAppear(perform: { self.onAppear() })
    }
    

    func onAppear(){
        print("ON APPEAR")
        CoreData.stack.context.refreshAllObjects()
    }
    
    private func delete(offsets: IndexSet) {
        withAnimation {
            offsets.map { filmRolls[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
