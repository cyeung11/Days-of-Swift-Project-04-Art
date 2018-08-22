//
//  PaintingTableViewCell.swift
//  Project 04 Art
//
//  Created by Chris on 21/8/2018.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class PaintingTableViewCell: UITableViewCell {

    var buttonClick: ButtonClick?
    var section: Int?
    @IBOutlet weak var paintImage: UIImageView!
    @IBOutlet weak var paintName: UILabel!
    @IBOutlet weak var paintDetail: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func moreDetail(_ sender: UIButton) {
        if let buttonClick = buttonClick, let section = section{
            buttonClick.click(atSection: section)
        }
    }
    
}
