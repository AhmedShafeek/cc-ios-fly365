//
//  ItemCell.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var nameLabel: MyLabel!
    @IBOutlet weak var underlineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadCell(item : Item, lastIndex : Bool) {
        self.nameLabel.text = item.name
        self.underlineView.isHidden = lastIndex
    }
}
