//
//  CameraListView.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI
import CoreData

struct CameraListView : View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Camera.make, ascending: true),
            NSSortDescriptor(keyPath: \Camera.model, ascending: true)
        ],
        animation: .default)
    private var cameras: FetchedResults<Camera>
    
    @State private var showingItemAddView: Bool = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                List() {
                    
                    Section()
                    {
                        
                        ForEach(self.cameras, id: \.self) { camera in
                        
                                NavigationLink(destination: CameraEditView(camera: camera))
                            { ListCell(main: camera.make, sub: camera.model) }
                        }
                            .onDelete(perform: self.delete)
                    }
                }
                HiddenNavigationLink(destination: CameraAddView(), isActive: self.$showingItemAddView)
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Cameras"), displayMode: .large)
            .navigationBarItems(trailing:
                HStack {
                ActivateButton(activates: $showingItemAddView) { Image(systemName: "plus") }
                } )
         }
    }

    private func delete(offsets: IndexSet) {
        withAnimation {
            offsets.map { cameras[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
