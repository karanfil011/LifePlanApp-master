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
    
    var goalTitles = ["Hello", "Darkness", "My", "Old", "Friend"]
    var timePeriods = ["2 min", "3 min", "4 min","5 min", "6 min"]
    
    override func viewDidLoad() {
        super.viewDidLoad()


        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        

    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goalTitles.count
    }
      
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as! SecondScreenCollectionViewCell
        
        cell.titleGoal.text = goalTitles[indexPath.row]
        cell.timePeriod.text = timePeriods[indexPath.row]
//        cell.iconImage.image = UIImage(named: "guitar")
        
        return cell
    }

}
