//
//  Camera+CoreDataProperties.swift
//  Analogger
//
//  Created by Ben Pirt on 17/09/2024.
//
//

import Foundation
import CoreData


extension Camera {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Camera> {
        return NSFetchRequest<Camera>(entityName: "Camera")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var make: String?
    @NSManaged public var model: String?

}

extension Camera : Identifiable {

}
