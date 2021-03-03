//
//  ContentView.swift
//  Shared
//
//  Created by Tariq Almazyad on 3/3/21.
//

import SwiftUI

// 15 create ListView
struct ListView: View {
    @StateObject var listViewModel = ListViewModel()
    var body: some View {
        NavigationView {
            List{
                
                if listViewModel.allTasks.isEmpty {
                    Text("There are no tasks")
                } else {
                    ForEach(listViewModel.filteredTasks) { task in
                        TaskCellView(listViewModel: listViewModel,
                                     taskCellViewModel: TaskCellViewModel(task))
                    }.onDelete(perform: listViewModel.realmRepository.deleteTask(at:))
                    .deleteDisabled(listViewModel.selectedTaskCategory != .completed)
                }
            }.listBackgroundModifier(backgroundColor: Color(#colorLiteral(red: 0.1097619608, green: 0.1096628532, blue: 0.1179399118, alpha: 1)))
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Realm SwiftUI", displayMode: .large)
            .overlay( BottomView(selectedTaskCategory: $listViewModel.selectedTaskCategory,
                                 isDetailViewShowing: $listViewModel.isDetailViewShowing),
                      alignment: .bottom )
            .sheet(isPresented: $listViewModel.isDetailViewShowing) {
                AddOrUpdateTaskView(task: listViewModel.selectedTask ?? Task(), listViewModel: listViewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .preferredColorScheme(.dark)
    }
}

