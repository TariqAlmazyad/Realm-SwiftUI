//
//  AddOrUpdateTaskView.swift
//  Realm SwiftUI
//
//  Created by Tariq Almazyad on 3/3/21.
//

import SwiftUI

struct AddOrUpdateTaskView: View {
    @ObservedObject var task: Task
    @ObservedObject var listViewModel: ListViewModel
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Task Info")) {
                    HStack{
                        TextField("add title", text: $task.title)
                        Button(action: {
                            task.isCompleted.toggle()
                            
                        }, label: {
                            Image(systemName: task.isCompleted ? "checkmark.circle" : "circle")
                        }).buttonStyle(BorderlessButtonStyle())
                      
                    }.foregroundColor(.white)
                }
                Button(action: {
                    updateList()
                }, label: {
                    HStack{
                        Image(systemName: "plus")
                        Text(viewTitle)
                    }.frame(width: UIScreen.main.bounds.width - 100, height: 50)
                    .background(Color(#colorLiteral(red: 0.1676910222, green: 0.1677447259, blue: 0.1727188528, alpha: 1)).cornerRadius(24))
                    .foregroundColor(.white)
                }).buttonStyle(BorderlessButtonStyle())
                .listRowBackground(Color(#colorLiteral(red: 0.1097619608, green: 0.1096628532, blue: 0.1179399118, alpha: 1)))
                   
            }.navigationBarTitle(viewTitle, displayMode: .large)
        }
    }
    
    fileprivate func updateList() {
        listViewModel.isDetailViewShowing.toggle()
        task.id == nil ? listViewModel.realmRepository.saveNewTask(task) : listViewModel.realmRepository.updateTask(task)
    }
    
   private var viewTitle: String {
        task.id == nil ? "Add New Task" : "Update Task"
    }
}

struct AddOrUpdateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddOrUpdateTaskView(task: .init(),
                            listViewModel: ListViewModel())
            .preferredColorScheme(.dark)
    }
}
