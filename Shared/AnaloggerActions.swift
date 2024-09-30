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
        let filmRolls = CoreDataSource<FilmRoll>()
            .sortKeys(sortKeys: [(key: "created", ascending: false)])
            .predicate(predicate: NSPredicate(format: "complete = 0"))
            .objects
        print("Found \(filmRolls.count) active film rolls")
        if filmRolls.count == 1 {
            return filmRolls[0]
        }
        return nil
    }
    
    public func logShot(filmRoll: FilmRoll) {
        print("logShot(filmRoll) called in shared actions")
        let location = locationViewModel.lastSeenLocation
        let filmShot = filmRoll.addFilmShot(
            lat: location?.coordinate.latitude as Double?,
            lon: location?.coordinate.longitude as Double?
        )
        locationViewModel.getCountryAndCity(for: location){ placemark in
            if placemark != nil {
                filmShot.country = placemark?.country
                filmShot.region = placemark?.administrativeArea
                filmShot.locality = placemark?.locality
                filmShot.street = placemark?.thoroughfare
                filmShot.locationName = placemark?.name
                filmShot.save()
            }
        }
        WidgetCenter.shared.reloadTimelines(ofKind: "com.pirt.analogger.AnaloggerWidget")
    }
    
    public func logShot() {
        print("logShot called in shared actions")
        guard let activeFilmRoll = getActiveFilmRoll() else { return }
        logShot(filmRoll: activeFilmRoll)
    }
    
}
