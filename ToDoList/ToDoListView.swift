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
                    VStack(alignment: .leading){
                        
                        Text("Tasks")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.white)
                            .padding(.leading, 20)
                        
                        List(toDoListViewModel.getTasks()) {task in
                            HStack{
                                VStack(alignment: .leading){
                                    Text("\(task.name)")
                                        .font(.title)
                                        .bold()
                                    Text("\(task.description)")
                                }
                                .padding()
                                Spacer()
                                Button(action: {
                                    toDoListViewModel.deleteItem(task: task)
                                    
                                }, label: {
                                    Image(systemName: "square")
                                })
                                .padding()
                            }
                            
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .listStyle(.inset)
                    }
                    
                    
                }
                
                
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        isPresented = true
                    }, label: {
                        Image(systemName: "pencil")
                            .foregroundStyle(.blue)
                            .font(.system(size: 30))
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                    })
                    .padding()
                }
            }
        }
        .fullScreenCover(isPresented: $isPresented, content: {
            AddItem(toDoListViewModel: toDoListViewModel)
        })
        
    }
}

struct AddItem: View {
    
    @Environment(\.dismiss) var dismiss
    @State var title: String = ""
    @State var description: String = ""
    @ObservedObject var toDoListViewModel: ToDoListViewModel
    @State var text: String = "Enter your text here"
    
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
                
                ZStack(alignment: .topLeading){
                    
                    if (text.count>0) {
                        Text(text)
                            .foregroundColor(Color.gray.opacity(0.5))
                            .padding()
                    }
                    TextEditor(text: $description)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(height: 300, alignment: .topLeading)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .scrollContentBackground(.hidden)
                    //  .colorMultiply(.gray)
                        .onTapGesture {
                            if (description.isEmpty){
                                self.text = ""
                            }
                        }
                }
                
                
                
                
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
