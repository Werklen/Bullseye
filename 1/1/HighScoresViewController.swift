//
//  HighScoresViewController.swift
//  1
//
//  Created by Валерия Неделько on 13.02.22.
//

import UIKit

class HighScoresViewController: UITableViewController, EditHighScoreViewControllerDelegate {
    func editHighScoreViewControllerDidCancel(_ controller: EditHighScoreViewController) {
        navigationController?.popViewController(animated:true)
    }
    
    func editHighScoreViewController(_ controller: EditHighScoreViewController, didFinishEditing item: HighScoreItem) {
        if let index = items.firstIndex(of: item) {
            // 2
            let indexPath = IndexPath(row: index, section: 0)
            let indexPaths = [indexPath]
            // 3
            tableView.reloadRows(at: indexPaths, with: .automatic)
        }
        // 4
        PersistencyHelper.saveHighScores(items)
        navigationController?.popViewController(animated:true)
    }
    
    var items = [HighScoreItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = PersistencyHelper.loadHighScores()
        if (items.count == 0) {
            resetHighScores()
        }
    }
    
    // MARK: - Actions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        // 1
        items.remove(at: indexPath.row)
        // 2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        PersistencyHelper.saveHighScores(items)
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighScoreItem",
                                                 for: indexPath)
        let item = items[indexPath.row]
        let nameLabel = cell.viewWithTag(1000) as! UILabel
        let scoreLabel = cell.viewWithTag(2000) as! UILabel
        nameLabel.text = item.name
        scoreLabel.text = String(item.score)
        
        return cell
    }
    
    @IBAction func resetHighScores() {
        items = [HighScoreItem]()
        tableView.reloadData()
        PersistencyHelper.saveHighScores(items)
    }
    
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        // 1
        let controller = segue.destination as!
        EditHighScoreViewController
        // 2
        controller.delegate = self
        // 3
        if let indexPath = tableView.indexPath(for: sender as!
                                                  UITableViewCell) {
            controller.highScoreItem = items[indexPath.row]
        }
    }
    
}
