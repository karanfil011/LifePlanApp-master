//
//  ChangeGoalViewController.swift
//  LifePlan
//
//  Created by Ali on 19.10.2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import UIKit
import CoreData

class ChangeGoalViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var fetchResultController: NSFetchedResultsController<Goal>!
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var goal = [Goal]()
    
    let goalIcon = [
        UIImage(named: "launch"),
        UIImage(named: "power"),
        UIImage(named: "sport"),
        UIImage(named: "company"),
        UIImage(named: "guitar"),
        UIImage(named: "task"),
        UIImage(named: "plane"),
        UIImage(named: "water-park"),
        UIImage(named: "mission")
    ]
    
    var changeGoalTitle: String?
    var changeGoalTime: Int16?
    var changeGoalDetailText: String?
    var changeGoalFeelingsText: String?
    
    @IBOutlet weak var changeCollectionview: UICollectionView!
    
    @IBOutlet weak var changeTitle: UITextField!
    
    @IBOutlet weak var changeTime: UITextField!
    
    @IBOutlet weak var changeDay: UIButton!
    
    @IBOutlet weak var changeMonths: UIButton!
    
    @IBOutlet weak var changeYear: UIButton!
    
    @IBOutlet weak var changeDetailText: UITextView!
    
    @IBOutlet weak var changeFeelingsText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeCollectionview.delegate = self
        changeCollectionview.dataSource = self
        
        if let layout = changeCollectionview.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        changeTitle.text = changeGoalTitle
        changeDetailText.text = changeGoalDetailText
        if changeGoalTime != nil {
            changeTime.text = " \(changeGoalTime ?? 00)"
        }
        changeFeelingsText.text = changeGoalFeelingsText
     
    }
    
    @IBAction func periodSelected(_ sender: Any) {
    }
    

    @IBAction func saveChangesPressed(_ sender: UIBarButtonItem) {
        
//        if let constants = goat as? [Goal] {
//            let moneyPerSecond = constants[0].title
//
//        }

//        var cons = goal
//        print(cons[2].title)
//        cons[1].title = changeTitle.text

        print(goal)
        
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goalIcon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ChangesCollectionViewCell
        
        cell.changesIcon.image = goalIcon[indexPath.item]
        
        return cell
    }
    
    
    func saveGoal() {
        
        do {
            try context?.save()
        }
        catch {
            print(error)
        }
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
