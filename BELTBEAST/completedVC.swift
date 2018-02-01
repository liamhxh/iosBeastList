//
//  completedVC.swift
//  BELTBEAST
//
//  Created by Liam He on 1/30/18.
//  Copyright © 2018 Liam He. All rights reserved.
//

import UIKit
import CoreData

class completedVC: UITableViewController {

    var tasks = [Task]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAll()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        fetchAll()
        tableView.reloadData()
    }

    func fetchAll() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Task")
        do{
            let result = try managedObjectContext.fetch(request)
            tasks = result as! [Task]
        }catch{
            print(error)
        }

        if tasks.count > 0{
            tasks = tasks.filter{$0.incomplete == false}
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "completedCell", for: indexPath)
        let item = tasks[indexPath.row]

        cell.textLabel?.text = item.title

        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E MMM d"
        cell.detailTextLabel?.text = dateFormatter.string(from: date)
        return cell
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = tasks[indexPath.row]
//        item.incomplete = true
//        do{
//            try managedObjectContext.save()
//        }catch{
//            print(error)
//        }
//        tasks.remove(at: indexPath.row)
//        tableView.reloadData()
//    }

    //*****************************************************************************   deleteing
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        var item : Task?
        item = tasks[indexPath.row]
        tasks.remove(at: indexPath.row)
        managedObjectContext.delete(item!)

        do {
            try managedObjectContext.save()
        }catch{
            print(error)
        }
        tableView.reloadData()
    }


}
