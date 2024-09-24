//
//  ContentView.swift
//  Analogger
//
//  Created by Ben Pirt on 15/09/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @StateObject var locationViewModel = LocationViewModel()
    
    @StateObject var liveActivityController = LiveActivityController()

    var body: some View {
        TabView {
            FilmRollListView()
                .environmentObject(locationViewModel)
                .environmentObject(liveActivityController)
            .tabItem {
                Image(systemName: "film.stack")
                Text("Film Rolls")
            }
            
            CameraListView()
            .tabItem {
                Image(systemName: "camera")
                Text("Cameras")
            }

            LensListView()
            .tabItem {
                Image(systemName: "camera.aperture")
                Text("Lenses")
            }
            
           FilmStockListView()
            .tabItem {
                Image(systemName: "list.and.film")
                Text("Film Stock")
            }
            
            NavigationView {
                VStack {
                    Text("Settings")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .background(Color.green)
                }
                .navigationTitle("Settings")
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
        .onAppear(perform: { self.onAppear() })
    }

    func onAppear(){
        locationViewModel.requestPermission()
    }
}
