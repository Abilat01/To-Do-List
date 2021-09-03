//
//  TableViewController.swift
//  To-Do-List
//
//  Created by Danya on 03.09.2021.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    //массив с задачами
    var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let context = getContext()
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        
        do {
            tasks = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch let erron as NSError {
            print(erron.localizedDescription)
        }
    }
    
    
    @IBAction func newTaskAlert(_ sender: UIBarButtonItem) {
        
        let alertControler = UIAlertController(title: "Новая задача", message: "Запишите новую задачу", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
            let tf = alertControler.textFields?.first
            if let saveTaskTF = tf?.text {
                self.saveTask(withTitle: saveTaskTF)
                self.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        alertControler.addTextField { _ in }
        alertControler.addAction(saveAction)
        alertControler.addAction(cancelAction)
        
        present(alertControler, animated: true, completion: nil)
    }
    
    //
    private func saveTask(withTitle title: String) {
        
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        let taskObject = Task(entity: entity, insertInto: context)
        taskObject.title = title
        
        do {
            try context.save()
            tasks.append(taskObject)
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    //
    private func getContext() -> NSManagedObjectContext {
        
        let AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return AppDelegate.persistentContainer.viewContext
        
    }
    
    //
    @IBAction func deleteAll(_ sender: UIBarButtonItem) {
        
        let context = getContext()
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                context.delete(object)
            }
        }
        
        do {
            try context.save()
            tableView.reloadData()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    
    // MARK: - Table view data source

    //колличество секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //коллчество ячеек в секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    //настройка ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let tasksText = tasks[indexPath.row]
        cell.textLabel?.text = tasksText.title

        return cell
    }
    
}
