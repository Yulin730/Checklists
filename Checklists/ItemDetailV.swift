//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Yulin Feng on 10/9/17.
//  Copyright © 2017 Yulin730. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailV)
    func itemDetailViewController(_ controller: ItemDetailV, didFinishAdding item: CheckListItem)
    func itemDetailViewController(_ controller: ItemDetailV, didFinishEditing item: CheckListItem)
}

class ItemDetailV: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    var itemToEdit: CheckListItem?
    
    weak var delegate: ItemDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit{
            title = "Edit Item"
            doneButton.title = "Save"
            textFiled.text = item.text
            doneButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textFiled.becomeFirstResponder()
    }
    
    @IBAction func cancel(){
        navigationController?.popViewController(animated: true)
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done(){
        if let itemToEdit = itemToEdit{
            itemToEdit.text = textFiled.text!
            delegate?.itemDetailViewController(self, didFinishEditing: itemToEdit)
        } else {
           // navigationController?.popViewController(animated: true)
            let item = CheckListItem()
            item.text = textFiled.text!
            item.isChecked = false
            delegate?.itemDetailViewController(self, didFinishAdding: item)
        }

    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFiled.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in:oldText)
        let newText = oldText.replacingCharacters(in: stringRange!, with: string)
        
        if newText.isEmpty{
            doneButton.isEnabled = false
        } else{
            doneButton.isEnabled = true
        }
        
        return true
    }


}
