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

    @NSManaged public var complete: Bool
    @NSManaged public var created: Date
    @NSManaged public var name: String
    @NSManaged public var camera: Camera
    @NSManaged public var filmStock: FilmStock
    @NSManaged public var lens: Lens?
    @NSManaged public var filmShots: NSSet?
    @NSManaged public var cameraAsa: Int16

    var sortedFilmShots : [FilmShot] {
        return filmShots?.sortedArray(
            using: [NSSortDescriptor(key: "timestamp", ascending: true)]) as? [FilmShot] ?? []
    }

}

// MARK: Generated accessors for filmShots
extension FilmRoll {

    @objc(addFilmShotsObject:)
    @NSManaged public func addToFilmShots(_ value: FilmShot)

    @objc(removeFilmShotsObject:)
    @NSManaged public func removeFromFilmShots(_ value: FilmShot)

    @objc(addFilmShots:)
    @NSManaged public func addToFilmShots(_ values: NSSet)

    @objc(removeFilmShots:)
    @NSManaged public func removeFromFilmShots(_ values: NSSet)

}

extension FilmRoll : Identifiable {

}
