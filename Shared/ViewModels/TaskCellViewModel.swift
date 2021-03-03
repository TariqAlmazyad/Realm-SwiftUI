//
//  TaskCellViewModel.swift
//  Realm SwiftUI
//
//  Created by Tariq Almazyad on 3/3/21.
//


import SwiftUI
import Combine

// 13 create TaskCellViewModel to handle the task that rendered in "" TaskCellView ""
class TaskCellViewModel: ObservableObject {
    @Published var task: Task
    @Published var isCompleted: String   = ""
    @Published var title: String         = ""
    @Published var realmRepository       = RealmRepository()
    
    private var anyCancellable = Set<AnyCancellable>()
    // 14 we initialize each single task since we render 1 task in each cell
    init(_ task: Task) {
        self.task = task
        $task
            .map{
                $0.isCompleted ? "checkmark.circle" : "circle"
            }
            .assign(to: \.isCompleted, on: self)
            .store(in: &anyCancellable)
        
        $task
            .map{
                $0.title
            }
            .replaceEmpty(with: "There is no title")
            .assign(to: \.title, on: self)
            .store(in: &anyCancellable)
    }
}
