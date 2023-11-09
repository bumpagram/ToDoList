//  ToDoModel.swift
//  ToDoList
//  Created by .b[u]mpagram  on 3/11/23.
//

import Foundation

struct ToDoModel {
    let id = UUID() // “This is a system-provided type that is a universally unique value that can be used to identify types. Anytime you create one, you're theoretically guaranteed to get a different value, making it a reliable unique identifier.”
    
    var title: String
    var isComplete: Bool
    var expiredDate: Date
    var notes: String?
    
    static func ==(left: ToDoModel, right: ToDoModel) -> Bool {
        return left.id == right.id
    }
    
    static func loadData() -> [ToDoModel]? {
        // имплементация позже при чтении данных с диска
        return nil
    }
    
    static func useSamples() -> [ToDoModel] {
        let todo1 = ToDoModel(title: "Example task one", isComplete: false, expiredDate: Date(), notes: "some description")
        let todo2 = ToDoModel(title: "Example task two", isComplete: true, expiredDate: Date(), notes: "some description")
        let todo3 = ToDoModel(title: "Example task three", isComplete: false, expiredDate: Date(), notes: "some description")
        return [todo1, todo2, todo3]
    }
    
    
}


