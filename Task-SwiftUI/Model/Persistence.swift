//
//  Persistence.swift
//  Task-SwiftUI
//
//  Created by hakkı can şengönül on 17.06.2022.
//

import CoreData

struct PersistenceController {
    // MARK: - 1.Persistent Controller(kalıcı denetleyici(tüm uygulamanın kullanması için singleton))
    static let shared = PersistenceController()
    // MARK: - Persistent Container(Kalıcı konteyner(Çekirdek veri yığınını başlatmak ve çekirdeği yüklemek için tercih edilen yoldur))
    let container: NSPersistentContainer
    
    // MARK: - INITIALIZATION(load the persistent store)
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Task_SwiftUI")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    // MARK: - 4. PREVIEW(SwiftUI için bir test yapılandırmasıdır)
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<5 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = "Sample task No\(i)"
            newItem.completion = false
            newItem.id = UUID()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
