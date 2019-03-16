//
//  SecondViewController.swift
//  MyDo
//
//  Created by Ramazan Abdullayev on 3/13/19.
//  Copyright © 2019 Ramazan Abdullayev. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var itemTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        addButton.layer.cornerRadius = 20
        
    }

    @IBAction func add(_ sender: Any) {
        
        itemTextField.resignFirstResponder()
        
        let itemsObject = UserDefaults.standard.object(forKey: "items")
        
        var items: [String]
        
        let inputString = itemTextField.text
        
        if let tempItems = itemsObject as? [String] {
            
            items = tempItems
            
            if !(inputString?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? "").isEmpty {
                
                items.append(itemTextField.text!)
                
            }
            
        } else {
            
            items = [itemTextField.text!]
            
        }
        
        UserDefaults.standard.set(items, forKey: "items")
        
        itemTextField.text = ""
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
}

class SwipableTabVCAddTask : AddTaskViewController {
    
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
