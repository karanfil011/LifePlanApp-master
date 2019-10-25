//
//  MainViewController.swift
//  LifePlan
//
//  Created by Ali on 05/10/2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, DisplayGoalInMain, NSFetchedResultsControllerDelegate, DeleteItemProtocol, EditProtocol {
    
    
    
    var fetchResultController: NSFetchedResultsController<Goal>!
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var goal = [Goal]()
    
    private var indexPathItem = 0
    
    func showGoalInMain() {
        goalsCollectionView.reloadData()
        
        loadGoal()
        
    }
    
   let checkboxImage = [
        UIImage(named: "checkedBox"),
        UIImage(named: "uncheckedBox")
    ]
    
        
    @IBOutlet var goalsCollectionView: UICollectionView!
    
    var goalTitles = [String]()
    var periodGoal = [String]()

    var goalsImageIcons = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalsCollectionView.delegate = self
        goalsCollectionView.dataSource = self
        
        
        let layout = self.goalsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 30)
//        layout.minimumInteritemSpacing = 5
//        layout.itemSize = CGSize(width: self.goalsCollectionView.frame.size.width - 20/2, height: self.goalsCollectionView.frame.size.height / 3)
    
        loadGoal()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goal.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GoalsCollectionViewCell
        
        cell.layer.cornerRadius = 5
        
        cell.goalTitleLabel.text = goal[indexPath.item].title
        cell.goalIconImage.image = UIImage(named: goal[indexPath.item].image!)
        cell.goalCost.text = String(goal[indexPath.item].cost)
        cell.checkbox.image = UIImage(named: "uncheckedBox")
        
        if goal[indexPath.item].importance == "important" {
            cell.layer.backgroundColor = UIColor.purple.cgColor
            cell.goalTitleLabel.textColor = .white
            cell.goalCost.textColor = .white
        }
        else if goal[indexPath.item].importance == "urgent" {
            cell.layer.backgroundColor = UIColor.red.cgColor
            cell.goalTitleLabel.textColor = .white
            cell.goalCost.textColor = .white
        }
        else if goal[indexPath.item].importance == "not much"{
//            cell.layer.borderColor = UIColor.black.cgColor
//            cell.layer.borderWidth = 2
            cell.layer.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            cell.goalTitleLabel.textColor = .white
            cell.goalCost.textColor = .white
//            cell.checkbox.layer.borderColor = UIColor.black.cgColor
//            cell.checkbox.layer.borderWidth = 2
//            cell.checkbox.layer.cornerRadius = 5
            

        }
        

        

        
        cell.index = indexPath
        cell.delegate = self
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let editVC = storyboard?.instantiateViewController(withIdentifier: "EditGoalViewController") as? EditGoalViewController

        editVC?.textFieldTitle = goal[indexPath.item].title
        editVC?.costGoal = String(goal[indexPath.item].cost)
        editVC?.textTextField = goal[indexPath.item].detailText
        editVC?.notification = goal[indexPath.item].dateTime
        editVC?.selectedImportanceButton = goal[indexPath.item].importance
        editVC?.selectedIconGoal = goal[indexPath.item].image
        
        indexPathItem = indexPath.item
        
//        arrayTitle.append(goal[indexPath.item].title!)
//        goal[indexPath.item].setValue(arrayTitle, forKey: "title")

        

//        detailVC?.icon = goal[indexPath.item].image
////        detailVC?.timePeriod = String(goal[indexPath.item].period) + " " + goal[indexPath.item].goalPeriod!
//        detailVC?.mindset = goal[indexPath.item].mindset
//        detailVC?.detailText = goal[indexPath.item].detailText
//        detailVC?.time = goal[indexPath.item].period

//        self.navigationController?.pushViewController(editVC!, animated: false)
        
        performSegue(withIdentifier: "EditCell", sender: editVC!)
    }
    
    
    func deleteItem(indx: Int) {
        context?.delete(goal[indx])
        goal.remove(at: indx)
        saveGoal()
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "addSegue", sender: self)
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addSegue" {
        
            let addGoalMainVC = segue.destination as! AddGoalMainViewController
            addGoalMainVC.delegate = self
        }
        else if segue.identifier == "EditCell" {
            let editVC = segue.destination as? EditGoalViewController
            editVC?.textFieldTitle = goal[indexPathItem].title
            editVC?.costGoal = String(goal[indexPathItem].cost)
            editVC?.textTextField = goal[indexPathItem].detailText
            editVC?.notification = goal[indexPathItem].dateTime
            editVC?.selectedImportanceButton = goal[indexPathItem].importance
            editVC?.selectedIconGoal = goal[indexPathItem].image
            
            editVC?.editDelegate = self
        }
        
    }
    
    func edit(title: String, detailText: String, notification: String, selectedImportance: String) {
        print("Here..")
//        print(someName)
        
        // Select specific indexpath
        goal[indexPathItem].setValue(title, forKey: "title")
        goal[indexPathItem].setValue(detailText, forKey: "detailText")
        goal[indexPathItem].setValue(notification, forKey: "dateTime")
        goal[indexPathItem].setValue(selectedImportance, forKey: "importance")
        
        
        saveGoal()
        goalsCollectionView.reloadData()
    }
    
    func saveGoal() {
        
        do {
            try context?.save()
        }
        catch {
            print(error)
        }
        self.goalsCollectionView.reloadData()
    }
    
    func loadGoal() {
        
        let request: NSFetchRequest<Goal> = Goal.fetchRequest()
        
        do {
            goal = try (context?.fetch(request))!
        }
        catch {
            print("Error is \(error)")
        }
        
    }
    

}
