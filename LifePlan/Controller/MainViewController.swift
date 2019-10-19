//
//  MainViewController.swift
//  LifePlan
//
//  Created by Ali on 05/10/2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, DisplayGoalInMain, NSFetchedResultsControllerDelegate, DeleteItemProtocol {
    
    var fetchResultController: NSFetchedResultsController<Goal>!
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var goal = [Goal]()
    
    
    func showGoalInMain() {
        goalsCollectionView.reloadData()
        loadGoal()
        
    }
    
        
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
        cell.timeLabel.text = String(goal[indexPath.item].period) + " " + goal[indexPath.item].goalPeriod!
        
        cell.index = indexPath
        cell.delegate = self
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailGoalViewController") as? DetailGoalViewController

        detailVC!.goalTitle = goal[indexPath.item].title!
        detailVC?.icon = goal[indexPath.item].image
        detailVC?.timePeriod = String(goal[indexPath.item].period) + " " + goal[indexPath.item].goalPeriod!

        self.navigationController?.pushViewController(detailVC!, animated: true)
    }
    
    
    func deleteItem(indx: Int) {
        context?.delete(goal[indx])
        goal.remove(at: indx)
        saveGoal()
    }
    
    
    @IBAction func deleteButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "addSegue", sender: self)
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addSegue" {
        
            let addGoalMainVC = segue.destination as! AddGoalMainViewController
            addGoalMainVC.delegate = self
        }
        
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
