//
//  DataTableCell.swift
//  Assignment
//
//  Created by Jorden Williams on 22/04/2022.
//

import Foundation
import UIKit
class DataTableCell : UITableViewCell{
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterDetails: UILabel!
    
    override class func awakeFromNib() {
        print("Do initializing code here")
    }
}

