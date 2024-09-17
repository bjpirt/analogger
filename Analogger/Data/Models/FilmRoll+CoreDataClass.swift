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
        return FilmRoll(context: CoreData.stack.context)
    }

    class func createFilmRoll(name: String) -> FilmRoll {
        let filmRoll = FilmRoll.newFilmRoll()
        filmRoll.name = name
        filmRoll.id = UUID()
        filmRoll.active = true
        filmRoll.created = Date()
        CoreData.stack.save()

        return filmRoll
    }

    public func update(name: String) {
        self.name = name
        CoreData.stack.save()
    }

    public func delete() {
        CoreData.stack.context.delete(self)
    }
}
