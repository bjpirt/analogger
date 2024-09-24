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
        .sortKeys(sortKeys: [(key: "created", ascending: false)])
    
    @State private var showingItemAddView: Bool = false
    
    @State private var shooting = false
    
    @EnvironmentObject var liveActivityController: LiveActivityController

    var body: some View {
        NavigationView {
            VStack {
                List() {
                    Section("Active Rolls")
                    {
                        ForEach(self.dataSource.objects) { filmRoll in
                            if !filmRoll.complete {
                                NavigationLink(destination: FilmRollView(filmRoll: filmRoll))
                                { FilmRollListCell(filmRoll: filmRoll) }
                            }
                        }
                            .onDelete(perform: self.dataSource.delete)
                        Toggle("Enable live activity", isOn: self.$shooting).onChange(of: self.shooting){ self.toggleLiveActivity() }
                    }
                    Section("Complete Rolls")
                    {
                        ForEach(self.dataSource.objects) { filmRoll in
                            if filmRoll.complete {
                                NavigationLink(destination: FilmRollView(filmRoll: filmRoll))
                                { FilmRollListCell(filmRoll: filmRoll) }
                            }
                        }
                            .onDelete(perform: self.dataSource.delete)
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
    }
    
    func toggleLiveActivity () {
        if self.shooting {
            self.liveActivityController.start()
            print("Toggling live activity on")
        }else{
            self.liveActivityController.endActivity()
            print("Toggling live activity off")
        }
    }
}
