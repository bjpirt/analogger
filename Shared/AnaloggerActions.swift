//
//  AnaloggerActions.swift
//  Analogger
//
//  Created by Ben Pirt on 24/09/2024.
//

import Foundation
import WidgetKit

@Observable
class AnaloggerActions {
    let coreDataContext = CoreData.stack.context
    
    static let shared = AnaloggerActions()
    
    private var locationViewModel = LocationViewModel()
    
    public func getActiveFilmRoll () -> FilmRoll? {
        let filmRollDataSource = CoreDataSource<FilmRoll>().sortKeys(sortKeys: [(key: "created", ascending: false)])
            .predicates(predicates: [NSPredicate(format: "complete == NO")])
        let filmRolls = filmRollDataSource.objects
        if filmRolls.count == 1 {
            return filmRolls[0]
        }
        return nil
    }
    
    public func logShot(filmRoll: FilmRoll) {
        print("logShot(filmRoll) called in shared actions")
        let location = locationViewModel.lastSeenLocation
        filmRoll.addFilmShot(
            lat: location?.coordinate.latitude as Double?,
            lon: location?.coordinate.longitude as Double?
        )
        WidgetCenter.shared.reloadTimelines(ofKind: "com.pirt.analogger.AnaloggerWidget")
    }
    
    public func logShot() {
        print("logShot called in shared actions")
        guard let activeFilmRoll = getActiveFilmRoll() else { return }
        logShot(filmRoll: activeFilmRoll)
    }
    
}
