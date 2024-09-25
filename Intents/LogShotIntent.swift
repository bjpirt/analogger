//
//  LogShotIntent.swift
//  Analogger
//
//  Created by Ben Pirt on 24/09/2024.
//

import Foundation
import AppIntents

struct LogShotIntent: AppIntent {
    static var title = LocalizedStringResource("Log Shot")
    static var description = IntentDescription("Logs a shot with Analogger")

    func perform() async throws -> some IntentResult & ProvidesDialog {
        print("LogShotIntent called")
        let actions: AnaloggerActions = .shared
        actions.logShot()
        return .result(dialog: .init("Shot logged"))
    }
}
