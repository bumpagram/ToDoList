//  ToDoCustomCell.swift
//  ToDoList
//  Created by .b[u]mpagram on 13/11/23.
//

import UIKit

protocol ToDoCustomCellDelegate: AnyObject  {
    func checkmarkTapped(source: ToDoCustomCell)
}


class ToDoCustomCell: UITableViewCell {
    
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    weak var delegate: ToDoCustomCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        delegate?.checkmarkTapped(source: self)
    }
    
    
    

}
