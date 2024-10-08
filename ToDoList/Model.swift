//
//  Model.swift
//  ToDoList
//
//  Created by Tayami Rai on 08/10/2024.
//

import Foundation

struct Task: Identifiable{
    let id: UUID = UUID()
    let name: String
    let description: String
}
