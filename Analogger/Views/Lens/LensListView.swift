//
//  LensListView.swift
//  Analogger
//
//  Created by Ben Pirt on 17/09/2024.
//

import SwiftUI
import CoreData

struct LensListView : View {

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Lens.make, ascending: true),
            NSSortDescriptor(keyPath: \Lens.model, ascending: true)
        ],
        animation: .default)
    private var lenses: FetchedResults<Lens>

    @State private var showingItemAddView: Bool = false

    var body: some View {

        NavigationView {
            VStack {
                List() {
                    Section()
                    {
                        ForEach(lenses) { lens in
                                NavigationLink(destination: LensEditView(lens: lens))
                            { ListCell(main: lens.make, sub: "\(lens.model) (\(lens.focalLength)mm)") }
                        }
                            .onDelete(perform: self.delete)
                    }
                }
                HiddenNavigationLink(destination: LensAddView(), isActive: self.$showingItemAddView)
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Lenses"), displayMode: .large)
            .navigationBarItems(trailing:
                HStack {
                ActivateButton(activates: $showingItemAddView) { Image(systemName: "plus") }
                } )
         }
    }

    private func delete(offsets: IndexSet) {
        withAnimation {
            offsets.map { lenses[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
