//  ToDoTableViewController.swift
//  ToDoList
//  Created by .b[u]mpagram  on 3/11/23.

import UIKit

class ToDoTableViewController: UITableViewController, ToDoCustomCellDelegate {
    
    func checkmarkTapped(source: ToDoCustomCell) {
        if let indexpath = tableView.indexPath(for: source) {
            print("flag checkmarkTapped income")
            var element = arrayOfToDos[indexpath.row]
            element.isComplete.toggle()
            arrayOfToDos[indexpath.row] = element
            tableView.reloadRows(at: [indexpath], with: .automatic)
            ToDoModel.saveData(of: arrayOfToDos)
        }
    }
    
    
    var arrayOfToDos = [ToDoModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        if let savedTodos = ToDoModel.loadData() {
            arrayOfToDos = savedTodos
        } else {
            arrayOfToDos = ToDoModel.useSamples()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    
    @IBAction func unwindToTodolist(insegue: UIStoryboardSegue) {
        // подключен вручную в сториборде, но xCode кружок не закрасил
        guard insegue.identifier == "savingUnwind" else {return}
        let sourceViewController = insegue.source as! DetailsTableViewController // не упадет ввиду guard
        
        if let toDoModel = sourceViewController.toDoModel {
            if let existingTaskIndex = arrayOfToDos.firstIndex(of: toDoModel) {
                // заменяет сохраненный элемент на обновленный, чтобы не было дублей
                arrayOfToDos[existingTaskIndex] = toDoModel
                tableView.reloadRows(at: [IndexPath(row: existingTaskIndex, section: 0)], with: .automatic)  // IP - инициализатор
                
            } else {
                // “If a model object exists, add it to the array, then add a table cell that represents the new data.”
                let insertIndexPath = IndexPath(row: arrayOfToDos.count, section: 0)
                arrayOfToDos.append(toDoModel)
                tableView.insertRows(at: [insertIndexPath], with: .automatic)
            }
        }
        ToDoModel.saveData(of: arrayOfToDos)
    }
    
    @IBSegueAction func editTodo(_ coder: NSCoder, sender: Any?) -> DetailsTableViewController? {
        // здесь определяется источник кнопка/ячейка и в destination view controller пробрасываетсся в проперти нужный элемент массива
        let detailsTVC = DetailsTableViewController(coder: coder)
        guard let cell = sender as? UITableViewCell, let indexpath = tableView.indexPath(for: cell) else {
            // if sender is the add button, return an empty controller
            return detailsTVC
        }
        tableView.deselectRow(at: indexpath, animated: true)
        detailsTVC?.toDoModel = arrayOfToDos[indexpath.row]
        return detailsTVC
    }
    
    
    // MARK: - Table view data source
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfToDos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // отображение кастомной ячейки
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! ToDoCustomCell
        cell.delegate = self // принимателем событий станет сам ToDoTableViewController
        let element = arrayOfToDos[indexPath.row]
        cell.titleLabel.text = element.title
        cell.isCompleteButton.isSelected = element.isComplete
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrayOfToDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToDoModel.saveData(of: arrayOfToDos)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
