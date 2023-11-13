//  ToDoCustomCell.swift
//  ToDoList
//  Created by .b[u]mpagram on 13/11/23.
//

import UIKit

class ToDoCustomCell: UITableViewCell {
    
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
