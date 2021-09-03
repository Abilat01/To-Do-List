//
//  TableViewController.swift
//  To-Do-List
//
//  Created by Danya on 03.09.2021.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    //Массив с задачами
    var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - save and delete Tasks
    
    
    @IBAction func newTaskAlert(_ sender: UIBarButtonItem) {
        //
        let alertControler = UIAlertController(title: "Новая задача", message: "Запишите новую задачу", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
            let tf = alertControler.textFields?.first
            if let newTaskTitle = tf?.text {
                self.saveTask(withTitle: newTaskTitle)
                self.tableView.reloadData()
            }
        }
        //
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        alertControler.addTextField { _ in }
        alertControler.addAction(saveAction)
        alertControler.addAction(cancelAction)
        
        present(alertControler, animated: true, completion: nil)
        
    }
    
    //
    private func getContext() -> NSManagedObjectContext {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
    
    }
    
    private func saveTask(withTitle title: String) {
        
       let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        
        let taskObject = Task(entity: entity, insertInto: context)
        taskObject.title = title
        
        do {
            try context.save()
            tasks.append(taskObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
    }
    
    @IBAction func deleteAll(_ sender: UIBarButtonItem) {
    }
    
    

    // MARK: - Table view data source

    //Колличество секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //Колличество ячеек в секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    //настройка секции
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let textTask = tasks[indexPath.row]
        cell.textLabel?.text = textTask.title

        return cell
    }

}
