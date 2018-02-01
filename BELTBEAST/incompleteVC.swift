//
//  ViewController.swift
//  BELTBEAST
//
//  Created by Liam He on 1/30/18.
//  Copyright © 2018 Liam He. All rights reserved.
//

import UIKit
import CoreData

class incompleteVC: UITableViewController, addTaskDelegate, cellDelegate {


    var editingTitle : String?
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

    func fetchAll(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Task")
        do{
            let result = try managedObjectContext.fetch(request)
            tasks = result as! [Task]
        }catch{
            print(error)
        }
        if tasks.count > 0{
            tasks = tasks.filter{$0.incomplete == true}
        }
    }



    @IBAction func AddPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "editSegue", sender: self)
    }


//************************* prepare segue ************************************
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let addTaskView = navigationController.topViewController as! addTaskVC
        addTaskView.delegate = self

        if ((sender as? IndexPath) != nil) {
            let ip = sender as! NSIndexPath
            addTaskView.indexPath = ip
            addTaskView.titleField = tasks[ip.row].title
        }

    }


//************************* populate the task ************************************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incompCell", for: indexPath) as! customCell

        let item = tasks[indexPath.row]
        cell.tabOneTitle.text = item.title

        cell.delegate = self

        return cell
    }

//************************* save task ************************************



    func saveItem(by: addTaskVC, title: String, incomplete: Bool, at indexPath: NSIndexPath?) {
        if let ip = indexPath{
            let item = tasks[ip.row]
            item.title = title
            item.incomplete = true
        }else{
            let item = NSEntityDescription.insertNewObject(forEntityName: "Task", into: managedObjectContext) as! Task

            item.title = title
            item.incomplete = true
            tasks.append(item)
        }

        do{
            try managedObjectContext.save()
        }catch{
            print(error)
        }

        fetchAll()
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }

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


//***************************************** BEAS BUTTON PRESSED *********************


    func beastCell(_ sender: customCell) {
        let indexPath = tableView.indexPath(for: sender)! as NSIndexPath
        let item = tasks[indexPath.row]
        item.incomplete = false
        do{
            try managedObjectContext.save()
        }catch{
            print(error)
        }
        tasks.remove(at: indexPath.row)
        tableView.reloadData()
    }


//***************************************** Editing *********************

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editSegue", sender: indexPath)
    }

}

