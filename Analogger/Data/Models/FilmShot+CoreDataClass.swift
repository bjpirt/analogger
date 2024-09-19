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

    class func createFilmShot(filmRoll: FilmRoll, camera: Camera, lens: Lens?) -> FilmShot {
        let filmStock = FilmShot.newFilmShot()
        filmStock.timestamp = Date.now
        filmStock.filmRoll = filmRoll
        filmStock.camera = camera
        filmStock.lens = lens
        CoreData.stack.save()

        return filmStock
    }

    public func update() {
        CoreData.stack.save()
    }

    public func delete() {
        CoreData.stack.context.delete(self)
    }
}
