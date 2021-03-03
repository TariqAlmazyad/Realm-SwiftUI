//
//  BottomView.swift
//  Realm SwiftUI
//
//  Created by Tariq Almazyad on 3/3/21.
//

import SwiftUI
struct BottomView: View {
    @Binding var selectedTaskCategory: TaskCategories
    @Binding var isDetailViewShowing : Bool
    var body: some View {
        VStack {
            Button(action: {
                isDetailViewShowing.toggle()
            }, label: {
                HStack{
                    Image(systemName: "plus")
                    Text("Add Task")
                }.frame(width: UIScreen.main.bounds.width - 100, height: 50)
                .background(Color(#colorLiteral(red: 0.1676910222, green: 0.1677447259, blue: 0.1727188528, alpha: 1)).cornerRadius(24))
                .foregroundColor(.white)
            })
            HStack {
                ForEach(TaskCategories.allCases, id:\.self) { taskCategory in
                    Button(action: {
                        withAnimation{
                            selectedTaskCategory = taskCategory
                        }
                    }, label: {
                        Text(taskCategory.title)
                            .foregroundColor(selectedTaskCategory == taskCategory ? .white : .gray)
                            .font(.system(size: selectedTaskCategory == taskCategory ? 16 : 14))
                            .padding()
                            .animation(.none)
                    })
                }
            }.padding()
        }
    }
}

struct BottomView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            BottomView(selectedTaskCategory: .constant(.all), isDetailViewShowing: .constant(false))
                .padding()
                .previewLayout(.sizeThatFits)
            ListView()
        }.preferredColorScheme(.dark)
    }
}
