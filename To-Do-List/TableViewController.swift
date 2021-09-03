//
//  TableViewController.swift
//  To-Do-List
//
//  Created by Danya on 03.09.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    //массив с задачами
    var tasks: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func newTaskAlert(_ sender: UIBarButtonItem) {
        
        let alertControler = UIAlertController(title: "Новая задача", message: "Запишите новую задачу", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
            let tf = alertControler.textFields?.first
            if let saveTask = tf?.text {
                self.tasks.append(saveTask)
                self.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        alertControler.addTextField { _ in }
        alertControler.addAction(saveAction)
        alertControler.addAction(cancelAction)
        
        present(alertControler, animated: true, completion: nil)
    }
    
    @IBAction func deleteAll(_ sender: UIBarButtonItem) {
        
        tasks.removeAll()
        tableView.reloadData()
        
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

        cell.textLabel?.text = tasks[indexPath.row]

        return cell
    }
    
}
