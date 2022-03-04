//
//  EditHighScoreTableViewController.swift
//  1
//
//  Created by Валерия Неделько on 4.03.22.
//

import UIKit

protocol EditHighScoreViewControllerDelegate: class {
    func editHighScoreViewControllerDidCancel(
        _ controller: EditHighScoreViewController)
    func editHighScoreViewController(
        _ controller: EditHighScoreViewController,
        didFinishEditing item: HighScoreItem)
}


class EditHighScoreViewController: UITableViewController, EditHighScoreViewControllerDelegate {
    
    func editHighScoreViewControllerDidCancel(_ controller: EditHighScoreViewController) {
        navigationController?.popViewController(animated:true)
    }
    
    func editHighScoreViewController(_ controller: EditHighScoreViewController, didFinishEditing item: HighScoreItem) {
        navigationController?.popViewController(animated:true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = highScoreItem.name
    }
    
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath)
    -> IndexPath? {
        return nil
    }
    
    weak var delegate: EditHighScoreViewControllerDelegate?
    var highScoreItem: HighScoreItem!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func cancel() {
        delegate?.editHighScoreViewControllerDidCancel(self)
        
    }
    @IBAction func done() {
        highScoreItem.name = textField.text!
        delegate?.editHighScoreViewController(self, didFinishEditing:
                                                highScoreItem)
    }
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    // MARK: - Text Field Delegates
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange,
                                                  with: string)
        doneBarButton.isEnabled = !newText.isEmpty
        
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
}
