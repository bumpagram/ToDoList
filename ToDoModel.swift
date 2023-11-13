//  ToDoModel.swift
//  ToDoList
//  Created by .b[u]mpagram  on 3/11/23.
//

import Foundation

struct ToDoModel : Equatable, Codable {
    let id : UUID // “This is a system-provided type that is a universally unique value that can be used to identify types. Anytime you create one, you're theoretically guaranteed to get a different value, making it a reliable unique identifier.”
    
    var title: String
    var isComplete: Bool
    var expiredDate: Date
    var notes: String?
    
    init(title: String, isComplete: Bool, expiredDate: Date, notes: String?) {
        // кастомный инициализатор для Codable
        self.id = UUID()
        self.title = title
        self.isComplete = isComplete
        self.expiredDate = expiredDate
        self.notes = notes
    }
    
    static func ==(left: ToDoModel, right: ToDoModel) -> Bool {
        return left.id == right.id
    }
    
    static func loadData() -> [ToDoModel]? {
        // при чтении данных с диска
        guard let codedTasks = try? Data(contentsOf: archiveURL) else {return nil}
        let decoder = PropertyListDecoder()
        
        return try? decoder.decode(Array<ToDoModel>.self, from: codedTasks)
    }
    
    static func saveData(of array: [ToDoModel]) {
        let encoder = PropertyListEncoder()
        let codedTasks = try? encoder.encode(array)  // закодировал массив в Data
        try? codedTasks?.write(to: archiveURL, options: .noFileProtection)  // записал Data в адрес проводника, создал файл
    }
    
    static func useSamples() -> [ToDoModel] {
        let todo1 = ToDoModel(title: "Example task one", isComplete: false, expiredDate: Date(), notes: "some description")
        let todo2 = ToDoModel(title: "Example task two", isComplete: true, expiredDate: Date(), notes: "some description")
        let todo3 = ToDoModel(title: "Example task three", isComplete: false, expiredDate: Date(), notes: "some description")
        return [todo1, todo2, todo3]
    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!  // путь в папку документов положили в константу
    static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")   // deprecated. в каком файле сохранить
    
}


