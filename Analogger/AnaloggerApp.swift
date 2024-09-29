//
//  AnaloggerApp.swift
//  Analogger
//
//  Created by Ben Pirt on 15/09/2024.
//

import CoreData
import SwiftUI

@main
struct AnaloggerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    let viewContext = CoreData.stack.context

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
