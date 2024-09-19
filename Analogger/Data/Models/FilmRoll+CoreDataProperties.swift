//
//  FilmRoll+CoreDataProperties.swift
//  Analogger
//
//  Created by Ben Pirt on 17/09/2024.
//
//

import Foundation
import CoreData


extension FilmRoll {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FilmRoll> {
        return NSFetchRequest<FilmRoll>(entityName: "FilmRoll")
    }

    @NSManaged public var active: Bool
    @NSManaged public var created: Date
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var camera: Camera?
    @NSManaged public var filmStock: FilmStock?
    @NSManaged public var lens: Lens?

}

extension FilmRoll : Identifiable {

}
