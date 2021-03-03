//
//  RealmRepository.swift
//  Realm SwiftUI
//
//  Created by Tariq Almazyad on 3/3/21.
//

import RealmSwift
import Combine
import SwiftUI


final class RealmRepository: ObservableObject {
    // 5 create the necessary properties
    @Published var realm = try! Realm()
    @Published var allTasks: Results<RealmTaskObject>?
    @Published var completedTasks: Results<RealmTaskObject>?
    @Published var unCompletedTasks: Results<RealmTaskObject>?
    @Published var isDetailViewShowing: Bool = false
    @Published var selectedTask: Task?
    
    
    init() {
       loadTasks()
    }
    
    func loadTasks(){
        allTasks         = realm.objects(RealmTaskObject.self)
        unCompletedTasks = realm.objects(RealmTaskObject.self).filter("isCompleted = false")
        completedTasks   = realm.objects(RealmTaskObject.self).filter("isCompleted = true")
    }
    
    // 8 create a func to save any new tasks
    /// save new task
    func saveNewTask(_ task: Task){
        objectWillChange.send()
        do {
            try realm.write{
                realm.add(RealmTaskObject(task))
                loadTasks()
            }
        } catch (let error){
            print("DEBUG: error while saving an object \(error.localizedDescription)")
        }
    }
    // 9 create func to update any tasks
    /// to update  selected current task
    func updateTask(_ task: Task){
        objectWillChange.send()
        do {
            try realm.write{
                realm.create(RealmTaskObject.self,
                             value: RealmTaskObject(task), //<- once we recieve a task , we transform it from Task to RealmTaskObject , since Realm only accepts Realm objects
                             update: .modified)
                loadTasks()
            }
        } catch (let error){
            print("DEBUG: error while saving an object \(error.localizedDescription)")
        }
    }
    
    // 10 create a func to delete any tasks , e.g in ForEach .onDelete(perform: viewModel.deleteTask)
    func deleteTask(at offsets: IndexSet){
        objectWillChange.send()
        guard let realmTaskObject = allTasks?.enumerated().first(where: {$0.offset == offsets.first})?.element else { return }
        do {
            try realm.write{
                realm.delete(realmTaskObject)
                loadTasks()
            }
        } catch(let error){
            print("DEBUG: error while deleting an object \(error.localizedDescription)")
        }
    }
}

