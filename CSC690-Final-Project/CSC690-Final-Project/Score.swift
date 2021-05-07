import Foundation
import CoreData


struct Score{
    let score: String
    
}

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
