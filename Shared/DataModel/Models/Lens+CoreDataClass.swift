//
//  Lens+CoreDataClass.swift
//  Analogger
//
//  Created by Ben Pirt on 17/09/2024.
//
//

import Foundation
import CoreData

@objc(Lens)
public class Lens: NSManagedObject {
    class func newLens() -> Lens {
        return Lens(context: CoreData.stack.context)
    }

    class func createLens(make: String, model: String, focalLength: Int16) -> Lens {
        let lens = Lens.newLens()
        lens.make = make
        lens.model = model
        lens.focalLength = focalLength
        CoreData.stack.save()

        return lens
    }

    public func update(make: String, model: String, focalLength: Int16) {
        self.make = make
        self.model = model
        self.focalLength = focalLength
        CoreData.stack.save()
    }

    public func delete() {
        CoreData.stack.context.delete(self)
    }
}
