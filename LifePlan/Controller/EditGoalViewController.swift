//
//  EditGoalViewController.swift
//  LifePlan
//
//  Created by Ali on 23.10.2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import UIKit

protocol EditProtocol {
//    func edit(ind: Int, name: String)
    func edit(title: String, detailText: String, notification: String, selectedImportance: String)
}

class EditGoalViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    

    
    @IBOutlet weak var editCost: UITextField!
    
    @IBOutlet weak var editText: UITextView!
    
    @IBOutlet weak var editDateTextField: UITextField!
    
    @IBOutlet weak var editNotMuchButton: UIButton!
    
    @IBOutlet weak var editImportantButton: UIButton!
    
    @IBOutlet weak var editUrgentButton: UIButton!
    
    @IBOutlet weak var editgoalcollectionview: UICollectionView!
    
    @IBOutlet weak var editTitle: UITextField!
    
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
    
    var editDelegate: EditProtocol?
    var indx: IndexPath?
    
    var textFieldTitle: String?
    var costGoal: String?
    var textTextField: String?
    var notification: String?
    
    var selectedImportanceButton: String!
    var selectedIconGoal: String!
//    var selectedImportanceButtonOne: String?
    var selectedGoalImage: String?
    
    var importanceString = ""
    var importanceIsSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editgoalcollectionview.delegate = self
        editgoalcollectionview.dataSource = self
        
        if let layout = editgoalcollectionview.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        editTitle.text = textFieldTitle
        editCost.text = costGoal!
        editText.text = textTextField
        editDateTextField.text = notification
        
        if importanceIsSelected == false {
            selectedImportance()
            importanceIsSelected = true
        }
        else {
            print("Something")
        }


    }
    

 
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        editDelegate?.edit(title: editTitle.text!, detailText: editText.text, notification: editDateTextField.text!, selectedImportance: importanceString)
        
        
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectedImportanceBtn(_ sender: UIButton) {
        
        
        
        if sender.tag == 1 && importanceIsSelected == true {
            importanceString = "urgent"
            
            editUrgentButton.backgroundColor = .red
            editUrgentButton.setTitleColor(.white, for: .normal)
            editUrgentButton.layer.cornerRadius = 5
            
            importanceIsSelected = true
            
            print(importanceString)
        }
        else if sender.tag == 2 && importanceIsSelected == true {
            importanceString = "important"
            
            editImportantButton.backgroundColor = .purple
            editImportantButton.setTitleColor(.white, for: .normal)
            editImportantButton.layer.cornerRadius = 5
            
            importanceIsSelected = true
            
            print(importanceString)
        }
        else if sender.tag == 3 && importanceIsSelected == true{
            importanceString = "not much"
            
            editNotMuchButton.layer.borderWidth = 1
            editNotMuchButton.layer.borderColor = UIColor.black.cgColor
            editNotMuchButton.setTitleColor(.black, for: .normal)
            editNotMuchButton.layer.cornerRadius = 5
            
            importanceIsSelected = true
            
            print(importanceString)
        }
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goalIcon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditIconCell", for: indexPath) as! EditImageCollectionViewCell
        cell.editIconImage.image = goalIcon[indexPath.item]
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditIconCell", for: indexPath) as! EditImageCollectionViewCell
//        cell.editIconImage.image = UIImage(named: selectedIconGoal)
//
//        cell.backgroundColor = .red
//
//
//    }

//    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditIconCell", for: indexPath) as! EditImageCollectionViewCell
//        cell.editIconImage.image = UIImage(named: selectedIconGoal)
//        cell.backgroundColor = .red
//        return true
//    }
//
    
    func selectedImportance() {
        if selectedImportanceButton == editImportantButton.titleLabel?.text {
            
            editImportantButton.backgroundColor = .purple
            editImportantButton.setTitleColor(.white, for: .normal)
            editImportantButton.layer.cornerRadius = 5
            
            
        }
        else if selectedImportanceButton == editUrgentButton.titleLabel?.text {
            editUrgentButton.backgroundColor = .red
            editUrgentButton.setTitleColor(.white, for: .normal)
            editUrgentButton.layer.cornerRadius = 5
            
        }
        else {
            editNotMuchButton.layer.borderWidth = 1
            editNotMuchButton.layer.borderColor = UIColor.black.cgColor
            editNotMuchButton.setTitleColor(.black, for: .normal)
            editNotMuchButton.layer.cornerRadius = 5
            
        }
    }
    
}
