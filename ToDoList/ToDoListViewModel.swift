//
//  ToDoListViewModel.swift
//  ToDoList
//
//  Created by Tayami Rai on 08/10/2024.
//

import Foundation

class ToDoListViewModel: ObservableObject{
    
    @Published var tasks: [Task] = []
    
    func createTask(name: String, description: String) -> Task{
        return Task(name: name, description: description)
    }
    
    func getTasks()->[Task] {
        return self.tasks
    }
    
    

    
    
}
