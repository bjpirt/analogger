//
//  CameraListView.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI
import CoreData

struct CameraListView : View {
    
    @StateObject private var dataSource = CoreDataSource<Camera>()
        .sortKeys(sortKey1: "make", sortKey2: "model")
    
    @State private var showingItemAddView: Bool = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                List() {
                    
                    Section()
                    {
                        
                        ForEach(self.dataSource.objects) { camera in
                        
                                NavigationLink(destination: CameraEditView(camera: camera))
                            { CameraListCell(make: camera.make!, model: camera.model!) }
                        }
                            .onDelete(perform: self.dataSource.delete)
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
//            .environment(\.editMode, self.$editMode)
         }
    }
}
