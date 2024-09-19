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
        filmRoll.active = true
        filmRoll.created = Date.now
        return filmRoll
    }

    class func createFilmRoll(name: String) -> FilmRoll {
        let filmRoll = FilmRoll.newFilmRoll()
        filmRoll.name = name
        
        CoreData.stack.save()

        return filmRoll
    }

    class func createFilmRollFromDraft(draftFilmRoll: DraftFilmRoll) -> FilmRoll {
        let filmRoll = FilmRoll.newFilmRoll()
        filmRoll.name = draftFilmRoll.name
        filmRoll.camera = draftFilmRoll.camera
        filmRoll.lens = draftFilmRoll.lens
        filmRoll.filmStock = draftFilmRoll.filmStock

        CoreData.stack.save()

        return filmRoll
    }

    public func update(name: String) {
        self.name = name
        CoreData.stack.save()
    }

    public func updateFromDraft(draftFilmRoll: DraftFilmRoll){
        self.name = draftFilmRoll.name
        self.camera = draftFilmRoll.camera
        self.lens = draftFilmRoll.lens
        self.filmStock = draftFilmRoll.filmStock

        CoreData.stack.save()
    }

    public func delete() {
        CoreData.stack.context.delete(self)
    }
    
    public func save(){
        CoreData.stack.save()
    }
}
