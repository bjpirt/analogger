//
//  Camera+CoreDataClass.swift
//  Analogger
//
//  Created by Ben Pirt on 17/09/2024.
//
//

import Foundation
import CoreData

@objc(Camera)
public class Camera: NSManagedObject {
        class func newCamera() -> Camera {
    
            return Camera(context: CoreData.stack.context)
        }
    
        class func createCamera(make: String, model: String) -> Camera {
    
            let camera = Camera.newCamera()
            camera.make = make
            camera.model = model
            CoreData.stack.save()
    
            return camera
        }
    
        public func update(make: String, model: String) {
    
            self.make = make
            self.model = model
            CoreData.stack.save()
        }
    
        public func delete() {
    
            CoreData.stack.context.delete(self)
        }
}
