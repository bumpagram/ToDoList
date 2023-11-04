//  DetailsTableViewController.swift
//  ToDoList
//  Created by .b[u]mpagram on 4/11/23.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var titleField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var notesField: UITextView!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState()
       
        
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
    }
    
    
    
    func updateSaveButtonState() {
        let shouldEnable = titleField.text?.isEmpty == false
        saveButton.isEnabled = shouldEnable
    }
    
    
    
    // MARK: - Navigation
    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
