//
//  FilmStock+CoreDataClass.swift
//  Analogger
//
//  Created by Ben Pirt on 17/09/2024.
//
//

import Foundation
import CoreData

@objc(FilmStock)
public class FilmStock: NSManagedObject {
    class func newFilmStock() -> FilmStock {
        return FilmStock(context: CoreData.stack.context)
    }

    class func createFilmStock(make: String, type: String, asa: Int16) -> FilmStock {
        let filmStock = FilmStock.newFilmStock()
        filmStock.make = make
        filmStock.type = type
        filmStock.asa = asa
        CoreData.stack.save()

        return filmStock
    }

    public func update(make: String, type: String, asa: Int16) {
        self.make = make
        self.type = type
        self.asa = asa
        CoreData.stack.save()
    }

    public func delete() {
        CoreData.stack.context.delete(self)
    }
}
