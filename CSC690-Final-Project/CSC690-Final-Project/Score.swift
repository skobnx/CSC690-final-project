import Foundation
import CoreData

// adapted from the core data example presented in class.

// defines a score object
struct Score{
    let score: String
    
}

// extend the struct to with initalizer with managed object
extension Score{
    init?(managedObject: NSManagedObject) {
        guard
            let score = managedObject.value(forKey: "score") as? String
        else {
            return nil
        }
        self.score = score
    }
}
