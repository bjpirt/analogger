//
//  FilmStock+CoreDataProperties.swift
//  Analogger
//
//  Created by Ben Pirt on 17/09/2024.
//
//

import Foundation
import CoreData


extension FilmStock {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FilmStock> {
        return NSFetchRequest<FilmStock>(entityName: "FilmStock")
    }

    @NSManaged public var asa: Int16
    @NSManaged public var id: UUID
    @NSManaged public var make: String
    @NSManaged public var type: String

}

extension FilmStock : Identifiable {

}
