//
//  FirstViewController.swift
//  MyDo
//
//  Created by Ramazan Abdullayev on 3/13/19.
//  Copyright © 2019 Ramazan Abdullayev. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var items: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.table.isEditing = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let itemsObject = UserDefaults.standard.object(forKey: "items")
        
        if let tempItems = itemsObject as? [String] {
            items = tempItems
        }
        
        table.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            items.remove(at: indexPath.row)
            table.reloadData()
            UserDefaults.standard.set(items, forKey: "items")
        }
    }
    
    /*
     
     // Chainging order of cell in table view
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.items[sourceIndexPath.row]
        items.remove(at: sourceIndexPath.row)
        items.insert(movedObject, at: destinationIndexPath.row)
    }
 
    */
    
}

class SwipableTabVC : TasksViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let left = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        left.direction = .left
        self.view.addGestureRecognizer(left)
        
        let right = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        right.direction = .right
        self.view.addGestureRecognizer(right)
    }
    
    @objc func swipeLeft() {
        let total = self.tabBarController!.viewControllers!.count - 1
        tabBarController!.selectedIndex = min(total, tabBarController!.selectedIndex + 1)
        
    }
    
    @objc func swipeRight() {
        tabBarController!.selectedIndex = max(0, tabBarController!.selectedIndex - 1)
    }
}
