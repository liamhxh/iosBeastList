//
//  addTaskVC.swift
//  BELTBEAST
//
//  Created by Liam He on 1/30/18.
//  Copyright © 2018 Liam He. All rights reserved.
//

import UIKit

class addTaskVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UITextField!


    var titleField : String?
    var delegate : addTaskDelegate?
    var indexPath : NSIndexPath?


    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.delegate = self
        titleLabel.text = titleField
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleLabel.resignFirstResponder()
        return true
    }


    @IBAction func DoneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.saveItem(by: self, title: titleLabel.text!, incomplete: true, at: indexPath)
    }


    @IBAction func CancelButtonPress(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }


}
