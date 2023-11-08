//  DetailsTableViewController.swift
//  ToDoList
//  Created by .b[u]mpagram on 4/11/23.

import UIKit

class DetailsTableViewController: UITableViewController {
    
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesIndexPath = IndexPath(row: 0, section: 2)
    var toDoModel: ToDoModel? // сюда пробросится элемент из инициализатора или из source - для деталей
    var isDatePickerHidden = true // flag
    
    
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var titleField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var notesField: UITextView!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState()
        datePicker.date = Date().addingTimeInterval(86400) // в секундах. + 24 часа от текущего
        updateDateLabel(input: datePicker.date)
    }
    
    
    @IBAction func textEditingChanged(_ sender: Any) {
        updateSaveButtonState()
    }
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
        // посыл событие - Primary Action Triggered = return key
    }
    @IBAction func isCompletePresed(_ sender: UIButton) {
        isCompleteButton.isSelected.toggle()
        titleField.resignFirstResponder()
        notesField.resignFirstResponder()
    }
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDateLabel(input: sender.date)
    }
    
    
    
    func updateSaveButtonState() {
        let shouldEnable = titleField.text?.isEmpty == false
        saveButton.isEnabled = shouldEnable
    }
    
    func updateDateLabel(input: Date) {
        dateLabel.text = input.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour().minute()   )  // будет выведен формат месяц-день-год , час-мин
        // один сложный составной аргумент
    }
    
    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == dateLabelIndexPath {
            titleField.resignFirstResponder()
            notesField.resignFirstResponder()
            isDatePickerHidden.toggle()
            tableView.beginUpdates() // “To animate a cell height adjustment”
            tableView.endUpdates() //
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
            case datePickerIndexPath where isDatePickerHidden == true : return 0
            // case datePickerIndexPath where isDatePickerHidden == false : return 220
            case notesIndexPath : return 100
            default : return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
            case datePickerIndexPath : return 220
            case notesIndexPath : return 100
            default : return UITableView.automaticDimension
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // “Save button performs an unwind segue when tapped, but you need to do some more work before the segue is performed.
        // In earlier lessons, you used the prepare(for:sender:) method to pass information from  one view controller to another. You'll use the same method here.
        
        guard segue.identifier == "savingUnwind" else {return}
        let savingTitle = titleField.text!
        let savingState = isCompleteButton.isSelected
        let savingEstimate = datePicker.date
        let savingNotes = notesField.text
        
        toDoModel = ToDoModel(title: savingTitle, isComplete: savingState, expiredDate: savingEstimate, notes: savingNotes)
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

    
    
} // ViewController end
