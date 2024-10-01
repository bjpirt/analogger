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

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var timestamp: Date
    @NSManaged public var filmRoll: FilmRoll
    @NSManaged public var camera: Camera
    @NSManaged public var lens: Lens?

    @NSManaged public var country: String?
    @NSManaged public var region: String?
    @NSManaged public var locality: String?
    @NSManaged public var street: String?
    @NSManaged public var locationName: String?

    @NSManaged public var fstop: String?
    @NSManaged public var shutterSpeed: String?
    @NSManaged public var evCompensation: String
}

extension FilmShot : Identifiable {

}
