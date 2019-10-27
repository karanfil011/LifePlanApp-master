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
    func edit(title: String, detailText: String, notification: String, selectedImportance: String, selectedImage: String)
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
    
    var selectedIndx = [Int]()
    var selectedImageIs = ""
    
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
    
    var datePicker: UIDatePicker?
    
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
        
        
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        editDateTextField.inputView = datePicker
        
        datePicker?.addTarget(self, action: #selector(EditGoalViewController.editDateChanged(datePicker:)), for: .valueChanged)
        

    }
    

 
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        
        if selectedIndx[0] == 0 {
            selectedImageIs = "launch"
        }
        else if selectedIndx[0] == 1 {
            selectedImageIs = "power"
        }
        else if selectedIndx[0] == 2 {
            selectedImageIs = "sport"
        }
        else if selectedIndx[0] == 3 {
            selectedImageIs = "company"
        }
        else if selectedIndx[0] == 4 {
            selectedImageIs = "guitar"
        }
        else if selectedIndx[0] == 5 {
            selectedImageIs = "task"
        }
        else if selectedIndx[0] == 6 {
            selectedImageIs = "plane"
        }
        else if selectedIndx[0] == 7 {
            selectedImageIs = "water-park"
        }
        else if selectedIndx[0] == 8 {
            selectedImageIs = "mission"
        }
        
        
        
        editDelegate?.edit(title: editTitle.text!, detailText: editText.text, notification: editDateTextField.text!, selectedImportance: importanceString, selectedImage: selectedImageIs)
        
        
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
            
            editNotMuchButton.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            editNotMuchButton.setTitleColor(.white, for: .normal)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        if cell!.isSelected {
            cell?.backgroundColor = .red
            cell?.layer.cornerRadius = 5
            if selectedIndx.contains(indexPath.item) {
                print("same")
            }
            else {
                selectedIndx.append(indexPath.item)
            }
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.backgroundColor = .clear
        
        let simage = selectedIndx.firstIndex(of: indexPath.item)!
        selectedIndx.remove(at: simage)
        
    }

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
            editNotMuchButton.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            editNotMuchButton.setTitleColor(.white, for: .normal)
            editNotMuchButton.layer.cornerRadius = 5
            
        }
    }
    
    @objc func editDateChanged(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, dd.MM.yy, HH:mm"
        
        editDateTextField.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    
    
}
