//
//  ViewController.swift
//  Note Plus
//
//  Created by NGUYENLONGTIEN on 7/5/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class GoalVC: UIViewController{
    //MARK: Models
    var goalArr = [Goal]()
    // MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView!
    // MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        //
        Goal.instance.getAllGoal { (goals) in
            self.goalArr = goals
            self.checkGoalArrToUpdateView()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Goal.instance.getAllGoal { (goals) in
            self.goalArr = goals
            self.tableView.reloadData()
            //
            self.checkGoalArrToUpdateView()
        }
    }
    // MARK: - UI event
    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        let creatGoal = CreateGoalVC()
        creatGoal.modalPresentationStyle = .custom
        //present(creatGoal, animated: true, completion: nil)
        presentDetail(creatGoal)
    }
    @IBAction func unwindSegueToGoalVC(segue:UIStoryboardSegue){
        
    }
    //MARK: Helper Method
    func checkGoalArrToUpdateView(){
        if goalArr.count == 0 {
            tableView.isHidden = true
        }else{
            tableView.isHidden = false
        }
    }
    func setProgressForGoal(at indexPath:IndexPath, completion: @escaping (_ results:Bool) -> Void){
        let managedObjectContext = AppDelegate.managedObjectContext
        var selectedGoal = goalArr[indexPath.row]
        if selectedGoal.goalProgress < selectedGoal.goalCompletionValue{
            selectedGoal.goalProgress += 1
            do{
                try managedObjectContext?.save()
                completion(true)
            }catch let error as NSError{
                print("Can not update goal progress for this object. Error is :\(error)")
                completion(false)
            }
        }
    }
    
    
}
extension GoalVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? GoalCell{
            let goal = goalArr[indexPath.row]
            if goal.goalProgress == goal.goalCompletionValue{
                cell.configureCell(with: goal.goalDescription!, goalType: goalType(rawValue: goal.goalType!)!, goalProgress: Int(goal.goalProgress))
                cell.completeGoalView.isHidden = false
            }else{
                cell.configureCell(with: goal.goalDescription!, goalType: goalType(rawValue: goal.goalType!)!, goalProgress: Int(goal.goalProgress))
                cell.completeGoalView.isHidden = true
            }
            return cell
        }else{
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var selectedGoal = goalArr[indexPath.row]
        let detailGoalVC = DetailGoalVC()
        detailGoalVC.goalSelected = selectedGoal
        detailGoalVC.modalPresentationStyle = .custom
        present(detailGoalVC, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: UITableViewRowAction.Style.destructive, title: "Delete") { (action, indexPath) in
            let seletedGoal = self.goalArr[indexPath.row]
            Goal.instance.deleteObject(object: seletedGoal) { (success) in
                if success{
                    self.goalArr.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
                    self.tableView.reloadData()
                }
            }
        }
        let addOne = UITableViewRowAction(style: UITableViewRowAction.Style.normal, title: "ADD 1") { (action, indexPath) in
            self.setProgressForGoal(at: indexPath) { (success) in
                if success{
                    self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                }
            }
        }
        addOne.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0.7034728168)
        return [delete, addOne]
    }
    
}

