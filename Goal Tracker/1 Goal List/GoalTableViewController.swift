//
//  GoalTableViewController.swift
//  Goal Tracker
//
//  Created by Deborah Newberry on 2/17/18.
//  Copyright © 2018 Deborah Newberry. All rights reserved.
//

import UIKit

class GoalSummaryTableViewCell: UITableViewCell {
    @IBOutlet weak var goalName: UILabel!
    @IBOutlet weak var goalExpirationDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutMargins = UIEdgeInsets.zero
    }
}

class GoalTableViewController: UITableViewController, ServiceDelegate {
    @IBOutlet weak var emptyStateLabel: UILabel!
    @IBAction func unwindToTable(segue:UIStoryboardSegue) { }
    @IBAction func createGoal(_ sender: Any) {
        performSegue(withIdentifier: "createGoalSegue", sender: sender)
    }
    
    var customView: UIView!
    let goalService = GoalService()
    var goals: [Goal] = []
    var labelsArray: Array<UILabel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goalService.delegate = self
        emptyStateLabel.center = self.view.center
        emptyStateLabel.isHidden = !goals.isEmpty
        
        self.refreshControl?.addTarget(self, action: #selector(GoalTableViewController.refresh), for: .valueChanged)
        self.refresh(sender: self)
        
        self.tableView.layoutMargins = UIEdgeInsets.zero
        self.tableView.separatorInset = UIEdgeInsets.zero
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.refresh(sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "goalSummaryCell", for: indexPath) as? GoalSummaryTableViewCell {
            let goal = goals[indexPath.row]
            cell.goalName.text = goal.name
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            
            cell.goalExpirationDate.text =  dateFormatter.string(from: goal.expiration)
            return cell
        }
        return GoalSummaryTableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var newGoals = goals
            newGoals.remove(at: indexPath.row)
            goalService.deleteGoal(id: goals[indexPath.row].id, newGoals: newGoals)
            //            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    @objc func refresh(sender: AnyObject) {
        self.goalService.fetchGoals()
    }
    
    func loadCustomRefreshContents() {
        let refreshContents = Bundle.main.loadNibNamed("RefreshView", owner: self, options: nil)!
        customView = refreshContents[0] as! UIView
        customView.frame = (refreshControl?.bounds)!
    }
    
    func success(data: Any?) {
        if let goalArray = data as? [Goal] {
            self.goals = goalArray
        }
        
        if let _ = self.refreshControl?.isRefreshing {
            self.refreshControl?.endRefreshing()
        }
        
        emptyStateLabel.isHidden = !goals.isEmpty
        self.tableView.reloadData()
    }
    
    func failure(message: String) {
        self.present(Utilities.createAlert(message: message), animated: true, completion: nil)
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
