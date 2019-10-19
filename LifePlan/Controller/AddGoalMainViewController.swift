//
//  AddGoalMainViewController.swift
//  LifePlan
//
//  Created by Ali on 05/10/2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import UIKit
import CoreData

protocol DisplayGoalInMain {
    func showGoalInMain()
    
}

class AddGoalMainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextViewDelegate, UITextFieldDelegate {
   
    @IBOutlet var addGoalCollectionView: UICollectionView!
    
    @IBOutlet var titleTextField: UITextField!
    
    @IBOutlet var numberTextField: UITextField!
    
    @IBOutlet var detailTextView: UITextView!
    
    @IBOutlet var mindsetTextField: UITextField!
    
    @IBOutlet var daysButton: UIButton!
    
    @IBOutlet var monthsButton: UIButton!
    
    @IBOutlet var yearButton: UIButton!
    
    var goal = [Goal]()
    
    var delegate: DisplayGoalInMain?
    
    var goalPeriod = ""
    var selectedIndex = [Int]()
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        addGoalCollectionView.delegate = self
        addGoalCollectionView.dataSource = self
        detailTextView.delegate = self
        titleTextField.delegate = self
        
        buttonDesign()
        
        

        if let layout = addGoalCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        detailTextView.text = "Write here.."
        detailTextView.textColor = UIColor.lightGray
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        loadGoal()
        
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
    
        
        let myGoal = Goal(context: context)
        myGoal.title = titleTextField.text
        myGoal.detailText = detailTextView.text
        myGoal.mindset = mindsetTextField.text
        myGoal.period = Int16(numberTextField.text!) ?? 0
        myGoal.goalPeriod = goalPeriod
        
        if selectedIndex[0] == 0 {
            myGoal.image = "launch"
        }
        else if selectedIndex[0] == 1 {
            myGoal.image = "power"
        }
        else if selectedIndex[0] == 2 {
            myGoal.image = "sport"
        }
        else if selectedIndex[0] == 3 {
            myGoal.image = "company"
        }
        else if selectedIndex[0] == 4 {
            myGoal.image = "guitar"
        }
        else if selectedIndex[0] == 5 {
            myGoal.image = "task"
        }
        else if selectedIndex[0] == 6 {
            myGoal.image = "plane"
        }
        else if selectedIndex[0] == 7 {
            myGoal.image = "water-park"
        }
        else if selectedIndex[0] == 8 {
            myGoal.image = "mission"
        }
        
        
        goal.append(myGoal)
        
        saveGoal()
        
        delegate?.showGoalInMain()

        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func goalDatePressed(_ sender: UIButton) {
        
        
        if sender.tag == 1 {
            
            sender.backgroundColor = .red
            sender.setTitleColor(.white, for: .normal)
            goalPeriod = "days"
        }
        
        else if sender.tag == 2 {
            sender.backgroundColor = .red
            sender.setTitleColor(.white, for: .normal)
            goalPeriod = "months"
        }
        
        else if sender.tag == 3 {
            sender.backgroundColor = .red
            sender.setTitleColor(.white, for: .normal)
            goalPeriod = "year"
        }
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        numberTextField.resignFirstResponder()
        detailTextView.resignFirstResponder()
        mindsetTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        detailTextView.resignFirstResponder()
        mindsetTextField.resignFirstResponder()
        
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goalIcon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AddGoalCollectionViewCell
        
        cell.goalIconImage.image = goalIcon[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        if cell!.isSelected {
            cell?.backgroundColor = .red
            cell?.layer.cornerRadius = 5
            if selectedIndex.contains(indexPath.item) {
                print("same")
            }
            else {
                selectedIndex.append(indexPath.item)
            }
            
        }
//        print(selectedIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.backgroundColor = .clear
        let vl = selectedIndex.firstIndex(of: indexPath.item)!
        selectedIndex.remove(at: vl)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = (detailTextView.text! as NSString).replacingCharacters(in: range, with: text)
        let numberOfCharacters = newText.count
        return numberOfCharacters < 320
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = titleTextField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 44
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if detailTextView.textColor == UIColor.lightGray {
            detailTextView.text = nil
            detailTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if detailTextView.text.isEmpty {
            detailTextView.text = "Write here.."
            detailTextView.textColor = UIColor.lightGray
        }
    }
    
    func saveGoal() {
        do {
            try context.save()
        }
        catch {
            print("Error saving goal \(error)")
        }
        
        addGoalCollectionView.reloadData()
    }
    
    
    func loadGoal() {
        let request: NSFetchRequest<Goal> = Goal.fetchRequest()
        do {
            goal = try context.fetch(request)
        }
        catch {
            print("Error loading goal \(error)")
        }
    }
    
    func buttonDesign() {
        
        daysButton.layer.cornerRadius = 5
        daysButton.backgroundColor = .white
        daysButton.setTitleColor(.black, for: .normal)
        
        daysButton.layer.shadowColor = UIColor.darkGray.cgColor
        daysButton.layer.shadowRadius = 4
        daysButton.layer.shadowOpacity = 0.5
        daysButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        
        monthsButton.layer.cornerRadius = 5
        monthsButton.backgroundColor = .white
        monthsButton.setTitleColor(.black, for: .normal)
        
        monthsButton.layer.shadowColor = UIColor.darkGray.cgColor
        monthsButton.layer.shadowRadius = 4
        monthsButton.layer.shadowOpacity = 0.5
        monthsButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        yearButton.layer.cornerRadius = 5
        yearButton.backgroundColor = .white
        yearButton.setTitleColor(.black, for: .normal)
        
        yearButton.layer.shadowColor = UIColor.darkGray.cgColor
        yearButton.layer.shadowRadius = 4
        yearButton.layer.shadowOpacity = 0.5
        yearButton.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
}
