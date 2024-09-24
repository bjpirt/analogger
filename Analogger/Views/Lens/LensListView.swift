//
//  LensListView.swift
//  Analogger
//
//  Created by Ben Pirt on 17/09/2024.
//

import SwiftUI
import CoreData

struct LensListView : View {

    @StateObject private var dataSource = CoreDataSource<Lens>()
        .sortKeys(sortKeys: [(key: "make", ascending: true), (key: "model", ascending: true)])

    @State private var showingItemAddView: Bool = false

    var body: some View {

        NavigationView {
            VStack {
                List() {
                    Section()
                    {
                        ForEach(self.dataSource.objects) { lens in
                                NavigationLink(destination: LensEditView(lens: lens))
                            { ListCell(main: lens.make, sub: "\(lens.model) (\(lens.focalLength)mm)") }
                        }
                            .onDelete(perform: self.dataSource.delete)
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
}
