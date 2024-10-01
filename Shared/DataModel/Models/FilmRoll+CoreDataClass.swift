//
//  FilmRoll+CoreDataClass.swift
//  Analogger
//
//  Created by Ben Pirt on 17/09/2024.
//
//

import Foundation
import CoreData

@objc(FilmRoll)
public class FilmRoll: NSManagedObject {

    class func newFilmRoll() -> FilmRoll {
        let filmRoll = FilmRoll(context: CoreData.stack.context)
        filmRoll.complete = false
        filmRoll.created = Date.now
        return filmRoll
    }

    class func createFilmRoll(name: String) -> FilmRoll {
        let filmRoll = FilmRoll.newFilmRoll()
        filmRoll.name = name
        
        CoreData.stack.save()

        return filmRoll
    }

    class func createFilmRoll(name: String, camera: Camera, filmStock: FilmStock, lens: Lens?, cameraAsa: Int16) -> FilmRoll {
        let filmRoll = FilmRoll.newFilmRoll()
        filmRoll.name = name
        filmRoll.camera = camera
        filmRoll.lens = lens
        filmRoll.filmStock = filmStock
        filmRoll.cameraAsa = cameraAsa

        CoreData.stack.save()

        return filmRoll
    }

    public func addFilmShot(lat: Double?, lon: Double?) -> FilmShot{
        return FilmShot.createFilmShot(filmRoll: self, camera: self.camera!, lens: self.lens, lat: lat, lon: lon)
    }

    public func delete() {
        CoreData.stack.context.delete(self)
    }
    
    public func save(){
        CoreData.stack.save()
    }
}
