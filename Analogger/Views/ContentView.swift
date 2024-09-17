//
//  ContentView.swift
//  Analogger
//
//  Created by Ben Pirt on 15/09/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    Text("Shoots")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .background(Color.green)
                }
                .navigationTitle("Shoots")
            }
            .tabItem {
                Image(systemName: "film.stack")
                Text("Shoots")
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
            
            NavigationView {
                VStack {
                    Text("Film Stock List")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .background(Color.green)
                }
                .navigationTitle("Film Stock")
            }
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
    }
}
