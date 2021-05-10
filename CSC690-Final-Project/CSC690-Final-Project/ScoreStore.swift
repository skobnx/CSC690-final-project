import Foundation
import CoreData

// interface for interacting with the core data store
// adapted from the core data example presented in class.
class ScoreStore {
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Scores")
        container.loadPersistentStores { (_, error: Error?) in
            if let error = error {
                fatalError("Something went wrong with the database")
            }
        }
        return container
    }()
    
    
    func store(score: Score) {
        let context = container.newBackgroundContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "ScoreEntity", in: context) else {
            return
        }
        
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        managedObject.setValue(score.score, forKey: "score")
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func getAllScores() -> [Score] {
        let context = container.viewContext
        
        // We are asking for all TodoItems. We could add "filters" to the request if we wanted to
        let request = NSFetchRequest<NSManagedObject>(entityName: "ScoreEntity")
        
        do {
            let results: [NSManagedObject] = try context.fetch(request)
            let todoItems: [Score] = results.compactMap { managedObject in
                return Score(managedObject: managedObject)
            }
            return todoItems
        } catch {
            print(error)
        }
        return []
    }
    
}
