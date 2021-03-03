//
//  TaskCellView.swift
//  Realm SwiftUI
//
//  Created by Tariq Almazyad on 3/3/21.
//

import SwiftUI
// 16 create TaskCellView
struct TaskCellView: View {
    @ObservedObject var listViewModel: ListViewModel
    @ObservedObject var taskCellViewModel: TaskCellViewModel
    var body: some View {
        HStack{
            Button(action: {
                withAnimation{
                    taskCellViewModel.task.isCompleted.toggle()
                    listViewModel.realmRepository.updateTask(taskCellViewModel.task)
                }
            }, label: {
                Image(systemName: taskCellViewModel.isCompleted)
                    .foregroundColor(.white)
            }).buttonStyle(BorderlessButtonStyle())
           Text(taskCellViewModel.title)
            .strikethrough(taskCellViewModel.task.isCompleted)
            
            Spacer()
            
            Button(action: {
                listViewModel.isDetailViewShowing.toggle()
                listViewModel.selectedTask = taskCellViewModel.task
            }, label: {
                Image(systemName: "gear")
                    .foregroundColor(.white)
            }).buttonStyle(BorderlessButtonStyle())
        }
    }
}



struct TaskCellView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCellView(listViewModel: ListViewModel(), taskCellViewModel: TaskCellViewModel(.init()))
            .padding()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
        ListView()
            .preferredColorScheme(.dark)
    }
}
