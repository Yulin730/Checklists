//
//  ViewController.swift
//  Checklists
//
//  Created by Yulin Feng on 10/6/17.
//  Copyright © 2017 Yulin730. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailV) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailV, didFinishEditing item: CheckListItem) {
        if let index = items.index(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailV, didFinishAdding item: CheckListItem) {
        
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexpaths = [indexPath]
        tableView.insertRows(at: indexpaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    
    var items: [CheckListItem] 
    
    
    
    @IBAction func addItem(_ sender: Any) {
        let newRowIndex = items.count
        let item = CheckListItem()
        let texts = ["text1", "text2", "text3", "text4", "text5"]
        let randomText = arc4random_uniform(UInt32(texts.count))
        item.text = texts[Int(randomText)]
        item.isChecked = false
        
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        items = [CheckListItem]()
        
        let row0Item = CheckListItem()
        row0Item.text = "1"
        row0Item.isChecked = false
        items.append(row0Item)
        
        let row1Item = CheckListItem()
        row1Item.text = "2"
        row1Item.isChecked = false
        items.append(row1Item)
        
        let row2Item = CheckListItem()
        row2Item.text = "3"
        row2Item.isChecked = false
        items.append(row2Item)
        
        let row3Item = CheckListItem()
        row3Item.text = "4"
        row3Item.isChecked = false
        items.append(row3Item)
        
        let row4Item = CheckListItem()
        row4Item.text = "5"
        row4Item.isChecked = false
        items.append(row4Item)
    
        super.init(coder: aDecoder)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! ItemDetailV
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailV
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
//        let indexpaths = [indexPath]
//        tableView.deleteRows(at: indexpaths, with: .automatic)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath){
            
            let item = items[indexPath.row]
            item.toggleChecked()

            configureCheckmark(for: cell, with: item)
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
       
        
        let item = items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        
        
        return cell
    }
    
    func configureText(for cell: UITableViewCell, with item: CheckListItem){
         let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item : CheckListItem){
        
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.isChecked{
            label.text = "√"
        }else{
            label.text = ""
        }
    }



}

