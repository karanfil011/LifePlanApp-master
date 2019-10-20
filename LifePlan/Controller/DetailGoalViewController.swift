//
//  DetailGoalViewController.swift
//  LifePlan
//
//  Created by Ali on 13.10.2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import UIKit

class DetailGoalViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
    
    @IBOutlet var detailCollectionView: UICollectionView!
    
    
    var goalTitle: String?
    var icon: String?
    var timePeriod: String?
    var detailText: String?
    var mindset: String?
    var time: Int16?
    
//    var goalTitles = ["Hello", "Darkness", "My", "Old", "Friend"]
//    var timePeriods = ["2 min", "3 min", "4 min","5 min", "6 min"]
    
    override func viewDidLoad() {
        super.viewDidLoad()


        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        

    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
      
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as! SecondScreenCollectionViewCell
        
        cell.layer.cornerRadius = 5
        
        cell.titleGoal.text = goalTitle
        cell.timePeriod.text = timePeriod
        cell.imageIcon.image = UIImage(named: icon!)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let changeVC = storyboard?.instantiateViewController(withIdentifier: "ChangeGoalViewController") as? ChangeGoalViewController
        
        changeVC?.changeGoalTitle = goalTitle
        changeVC?.changeGoalDetailText = detailText
        changeVC?.changeGoalTime = time
        changeVC?.changeGoalFeelingsText = mindset
        
        
        self.navigationController?.pushViewController(changeVC!, animated: true)
    }

}
