//
//  AnaloggerActions.swift
//  Analogger
//
//  Created by Ben Pirt on 24/09/2024.
//

import Foundation

@Observable
class AnaloggerActions {
    let coreDataContext = CoreData.stack.context
    
    static let shared = AnaloggerActions()
    
    private var locationViewModel = LocationViewModel()
    
    private var filmRollDataSource = CoreDataSource<FilmRoll>()
    
    public func logShot(filmRoll: FilmRoll) {
        let location = locationViewModel.lastSeenLocation
        filmRoll.addFilmShot(
            lat: location?.coordinate.latitude as Double?,
            lon: location?.coordinate.longitude as Double?
        )
    }
    
    private func getActiveFilmRoll () -> FilmRoll? {
        let filmRollDataSource = CoreDataSource<FilmRoll>().sortKeys(sortKeys: [(key: "created", ascending: false)])
//            .predicates(predicates: [NSPredicate(format: "complete == NO")])
        let filmRolls = filmRollDataSource.objects
        print("Received \(filmRolls.count) film rolls")
        if filmRolls.count == 1 {
            return filmRolls[0]
        }
        return nil
    }
    
    public func logShot() {
        print("logShot called in shared actions")
        guard let activeFilmRoll = getActiveFilmRoll() else { return }
        logShot(filmRoll: activeFilmRoll)
    }
    
}
