//
//  FilmShot+CoreDataProperties.swift
//  Analogger
//
//  Created by Ben Pirt on 19/09/2024.
//
//

import Foundation
import CoreData


extension FilmShot {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FilmShot> {
        return NSFetchRequest<FilmShot>(entityName: "FilmShot")
    }

    @NSManaged public var lat: NSDecimalNumber?
    @NSManaged public var lon: NSDecimalNumber?
    @NSManaged public var timestamp: Date
    @NSManaged public var filmRoll: FilmRoll
    @NSManaged public var camera: Camera
    @NSManaged public var lens: Lens?

}

extension FilmShot : Identifiable {

}
