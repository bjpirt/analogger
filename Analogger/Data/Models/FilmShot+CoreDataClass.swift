//
//  FilmShot+CoreDataClass.swift
//  Analogger
//
//  Created by Ben Pirt on 19/09/2024.
//
//

import Foundation
import CoreData

@objc(FilmShot)
public class FilmShot: NSManagedObject {
    class func newFilmShot() -> FilmShot {
        return FilmShot(context: CoreData.stack.context)
    }

    class func createFilmShot(filmRoll: FilmRoll, camera: Camera, lens: Lens?, lat: Double?, lon: Double?) -> FilmShot {
        let filmShot = FilmShot.newFilmShot()
        filmShot.timestamp = Date.now
        filmShot.filmRoll = filmRoll
        filmShot.camera = camera
        filmShot.lens = lens
        if lat != nil && lon != nil {
            filmShot.lat = lat!
            filmShot.lon = lon!
        }
        CoreData.stack.save()

        return filmShot
    }

    public func update() {
        CoreData.stack.save()
    }

    public func delete() {
        CoreData.stack.context.delete(self)
    }
}
