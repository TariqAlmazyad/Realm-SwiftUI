//
//  ListViewModel.swift
//  Realm SwiftUI
//
//  Created by Tariq Almazyad on 3/3/21.
//


import SwiftUI
import Combine


enum TaskCategories: String, CaseIterable {
    case all
    case completed
    case unCompleted
    
    var title: String{
        switch self {
        case .all:         return "All"
        case .completed:   return "Completed"
        case .unCompleted: return "Uncompleted"
        }
    }
}


final class ListViewModel: ObservableObject {
    @Published var realmRepository           = RealmRepository()
    
    @Published var allTasks                  = [Task]()
    @Published var completedTasks            = [Task]()
    @Published var unCompletedTasks          = [Task]()
    @Published var isDetailViewShowing       = false
    @Published var selectedTask              : Task?
    @Published var selectedTaskCategory      : TaskCategories = .all
    private var anyCancellable               = Set<AnyCancellable>()
    
    init() {
        realmRepository.$allTasks
            .receive(on: RunLoop.main)
            .compactMap{
                $0.map{
                    $0.map{
                        Task($0)
                    }
                }
            }
            .assign(to: \.allTasks, on: self)
            .store(in: &anyCancellable)
        
        realmRepository.$unCompletedTasks
            .receive(on: RunLoop.main)
            .compactMap{
                $0.map{
                    $0.map{
                        Task($0)
                    }
                }
            }
            .assign(to: \.unCompletedTasks, on: self)
            .store(in: &anyCancellable)
        
        realmRepository.$completedTasks
            .receive(on: RunLoop.main)
            .compactMap{
                $0.map{
                    $0.map{
                        Task($0)
                    }
                }
            }
            .assign(to: \.completedTasks, on: self)
            .store(in: &anyCancellable)
    }
    
    var filteredTasks: [Task] {
        switch selectedTaskCategory {
        case .all:         return allTasks
        case .completed:   return completedTasks
        case .unCompleted: return unCompletedTasks
        }
    }
    
    
     func resetSelectedTask() {
        selectedTask = nil
        realmRepository.loadTasks()
    }
    
}

