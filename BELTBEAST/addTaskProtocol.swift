//
//  addTaskProtocol.swift
//  BELTBEAST
//
//  Created by Liam He on 1/30/18.
//  Copyright © 2018 Liam He. All rights reserved.
//

import UIKit

protocol addTaskDelegate: class{
    func saveItem(by: addTaskVC, title: String, incomplete : Bool, at indexPath:NSIndexPath?)
}
