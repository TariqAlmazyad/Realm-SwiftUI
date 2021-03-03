//
//  TaskModel.swift.swift
//  Realm SwiftUI
//
//  Created by Tariq Almazyad on 3/3/21.
//

import Foundation
import RealmSwift
import Combine

// 1 Create Task class
class Task: ObservableObject, Identifiable {
    @Published var id: String? // we make the id optional since new tasks do not have IDs
    @Published var title: String = ""
    @Published var price: Double = 0.0
    @Published var isCompleted: Bool = false
    
    init() {}
    /// to pass RealmTaskObject and it returns --> Task to save in RealmDB
    init(_ realmTaskObject: RealmTaskObject) {
        id = realmTaskObject.id
        title = realmTaskObject.title
        price = realmTaskObject.price
        isCompleted = realmTaskObject.isCompleted
    }
}

// 2 create Realm Object class
class RealmTaskObject: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var price: Double = 0.0
    @objc dynamic var isCompleted: Bool = false
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    override init() {}
    
    // 3 create an initializer so that whenever we modify a task, we need to transform it from Realm object to Task object, otherwise Realm will throw error that we can not edit a Realm object
    init(_ task: Task) {
        id = task.id ?? UUID().uuidString // we make the id optional since new tasks do not have IDs
        title = task.title
        price = task.price
        isCompleted = task.isCompleted
    }
}

