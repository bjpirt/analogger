//
//  LiveActivityController.swift
//  Analogger
//
//  Created by Ben Pirt on 24/09/2024.
//

import Foundation
import SwiftUI
import BackgroundTasks
import ActivityKit

final class LiveActivityController: ObservableObject {
    @MainActor @Published private(set) var activityID: String?

    func start() {
        Task {
            await cancelAllRunningActivities()
            startNewLiveActivity()
        }
    }

    func updateLiveActivity() {
        Task {
          guard let activityID = await activityID,
                let runningActivity = Activity<AnaloggerWidgetAttributes>.activities.first(where: { $0.id == activityID }) else {
            return
          }

            let update = AnaloggerActivityAttributes.ContentState(rolls: ["Roll one", "Roll two"], shotCounts:[3, 10])
          let staleDate = Date(timeIntervalSinceNow: 60 * 60)
          await runningActivity.update(ActivityContent(state: update, staleDate: staleDate))
        }
    }

    func endActivity() {
        Task {
          guard let activityID = await activityID,
                let runningActivity = Activity<AnaloggerActivityAttributes>.activities.first(where: { $0.id == activityID }) else {
            return
          }

            let endContent = AnaloggerActivityAttributes.ContentState(rolls: [], shotCounts:[])
          await runningActivity.end(
            ActivityContent(state: endContent, staleDate: Date.distantFuture),
            dismissalPolicy: .immediate
          )

          await MainActor.run { self.activityID = nil }
        }
    }

    private func cancelAllRunningActivities() async {
        for activity in Activity<AnaloggerActivityAttributes>.activities {
            let endState = AnaloggerActivityAttributes.ContentState(rolls: [], shotCounts:[])
          await activity.end(
            ActivityContent(state: endState, staleDate: Date()),
            dismissalPolicy: .immediate
          )
        }

        await MainActor.run {
          activityID = nil
        }
    }

    private func startNewLiveActivity() {
        Task {
            let content = AnaloggerActivityAttributes.ContentState(rolls: ["Roll one", "Roll two"], shotCounts:[3, 10])

            let staleDate = Date(timeIntervalSinceNow: 60 * 60)

            let activity = try? Activity.request(
                attributes: AnaloggerActivityAttributes(),
                content: ActivityContent(
                    state: content,
                    staleDate: staleDate,
                    relevanceScore: 100
                )
            )

            await MainActor.run { activityID = activity?.id }
        }
    }

}
