//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Tayami Rai on 08/10/2024.
//

import SwiftUI

struct ToDoListView: View {
    
    @StateObject var toDoListViewModel: ToDoListViewModel = ToDoListViewModel()
    
    @State var isPresented: Bool = false
    @State var isListShowing: Bool = false
    
    var body: some View {
        ZStack{
            Color.blue.ignoresSafeArea(.all)
            VStack{
                
                Spacer()
                
                if(toDoListViewModel.getTasks().isEmpty){
                    Text("Create a to do list")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                } else {
                    ForEach(toDoListViewModel.getTasks()) {task in
                        Text("\(task.name)")
                        
                    }
                }
                
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        isPresented = true
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.blue)
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                    })
                    .padding()
                }
            }
        }
        .fullScreenCover(isPresented: $isPresented, content: {
            AddItem()
        })
        
    }
}

struct AddItem: View {
    
    @Environment(\.dismiss) var dismiss
    @State var title: String = ""
    @State var description: String = ""
    @ObservedObject var toDoListViewModel: ToDoListViewModel = ToDoListViewModel()
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "multiply")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                })
                .padding()
                Spacer()
            }
            VStack{
                TextField("Title of your task", text: $title)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                TextField("Describe your task", text: $description)
                    .frame(height: 300, alignment: .topTrailing)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
                Button(action: {
                    let task = toDoListViewModel.createTask(name: title, description: description)
                    
                    toDoListViewModel.tasks.append(task)
                    dismiss()

                }, label: {
                    Text("Add")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                })

            }
            .padding()
            
            Spacer()
        }

    }
}

#Preview {
    ToDoListView()
}
