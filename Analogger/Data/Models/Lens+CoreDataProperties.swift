//
//  Lens+CoreDataProperties.swift
//  Analogger
//
//  Created by Ben Pirt on 17/09/2024.
//
//

import Foundation
import CoreData


extension Lens {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lens> {
        return NSFetchRequest<Lens>(entityName: "Lens")
    }

    @NSManaged public var focalLength: Int16
    @NSManaged public var make: String
    @NSManaged public var model: String

}

extension Lens : Identifiable {

}
