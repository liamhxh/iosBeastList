//
//  customCell.swift
//  BELTBEAST
//
//  Created by Liam He on 1/30/18.
//  Copyright © 2018 Liam He. All rights reserved.
//

import UIKit

protocol cellDelegate: class{
    func beastCell(_ sender:customCell)
}


class customCell: UITableViewCell {
    weak var delegate: cellDelegate?

    @IBAction func BeastButtonPressed(_ sender: UIButton) {
        delegate?.beastCell(self)
    }

    @IBOutlet weak var tabOneTitle: UILabel!

}
