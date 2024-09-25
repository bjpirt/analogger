//
//  ShortcutsProvider.swift
//  Analogger
//
//  Created by Ben Pirt on 25/09/2024.
//

import AppIntents

struct ShortcutsProvider: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: LogShotIntent(),
                    phrases: ["Log shot in \(.applicationName)"],
                    shortTitle: "Log shot",
                    systemImageName: "camera")
    }
}
