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
    
    
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet var addGoalCollectionView: UICollectionView!
    
    @IBOutlet var titleTextField: UITextField!
    
    @IBOutlet var numberTextField: UITextField!
    
    @IBOutlet var detailTextView: UITextView!
    
    @IBOutlet weak var urgentButton: UIButton!
    
    @IBOutlet weak var importantButton: UIButton!
    
    @IBOutlet weak var notMuchButton: UIButton!
    
    var goal = [Goal]()
    
    var delegate: DisplayGoalInMain?
    
    var importance = ""
    var selectedIndex = [Int]()
    
    var datePicker: UIDatePicker?
    
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
        
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        
        dateTextField.inputView = datePicker
        
        datePicker?.addTarget(self, action: #selector(AddGoalMainViewController.dateChanged(datePicker:)), for: .valueChanged)
        

//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddGoalMainViewController.viewTapped(gestureRecognizer:)))
        
//        view.addGestureRecognizer(tapGesture)
        
        if let layout = addGoalCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        detailTextView.text = "Write here.."
        detailTextView.textColor = UIColor.lightGray
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        loadGoal()
        
    }
    
//    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
//        view.endEditing(true)
//    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, dd.MM.yy, HH:mm"
        
        dateTextField.text = dateFormatter.string(from: datePicker.date)
//        view.endEditing(true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
    
        
        let myGoal = Goal(context: context)
        myGoal.title = titleTextField.text
        myGoal.detailText = detailTextView.text
        myGoal.cost = Int16(numberTextField.text!) ?? 10
        myGoal.checked = false
        myGoal.importance = importance
        myGoal.dateTime = dateTextField.text
        
//        myGoal.date = Date(timeIntervalSince1970: dateTextField!.text)

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
    
    
    
    @IBAction func importanceBtnPressed(_ sender: UIButton) {
        
        if sender.tag == 1 {
            
            sender.backgroundColor = .red
            sender.setTitleColor(.white, for: .normal)
            importance = "urgent"
        }
            
        else if sender.tag == 2 {
            sender.backgroundColor = .purple
            sender.setTitleColor(.white, for: .normal)
            importance = "important"
        }
            
        else if sender.tag == 3 {
            sender.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            sender.setTitleColor(.white, for: .normal)
            importance = "not much"
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        numberTextField.resignFirstResponder()
        detailTextView.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        detailTextView.resignFirstResponder()
        
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
        
        urgentButton.layer.cornerRadius = 5
        urgentButton.backgroundColor = .white
        urgentButton.setTitleColor(.black, for: .normal)
        
        urgentButton.layer.shadowColor = UIColor.darkGray.cgColor
        urgentButton.layer.shadowRadius = 4
        urgentButton.layer.shadowOpacity = 0.5
        urgentButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        
        importantButton.layer.cornerRadius = 5
        importantButton.backgroundColor = .white
        importantButton.setTitleColor(.black, for: .normal)
        
        importantButton.layer.shadowColor = UIColor.darkGray.cgColor
        importantButton.layer.shadowRadius = 4
        importantButton.layer.shadowOpacity = 0.5
        importantButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        notMuchButton.layer.cornerRadius = 5
        notMuchButton.backgroundColor = .white
        notMuchButton.setTitleColor(.black, for: .normal)
        
        notMuchButton.layer.shadowColor = UIColor.darkGray.cgColor
        notMuchButton.layer.shadowRadius = 4
        notMuchButton.layer.shadowOpacity = 0.5
        notMuchButton.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
}
