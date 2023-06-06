//
//  ViewController.swift
//  Tippy
//
//  Created by Satyam Sovan Mishra on 06/06/23.
//

import UIKit

class ViewController: UIViewController {
    
    // Error message
    let errorMessage: String = "Please enter some valid values in the above fields."
    
    // Prefix for success message
    let messagePrefix: String = "The total amount per person is ₹"
    
    // Reference to tip amount field
    @IBOutlet weak var tipAmount: UITextField!
    
    // Reference to tip percent field
    @IBOutlet weak var tipPercent: UITextField!
    
    // Reference to total people field
    @IBOutlet weak var totalPeople: UITextField!
    
    // Reference to message label
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // On inital load, show default values (0.0) to user
        setDefaultValuesInUI()
    }

    // Defines when user presses calculate button
    @IBAction func onCalculatePressed(_ sender: UIButton) {
        
        // Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        // Checking for errors in data
        let errorInData = checkErrorInData(totalAmount: tipAmount.text!, tipPercent: tipPercent.text!, totalPeople: totalPeople.text!)
        
        var totalAmountPerPerson: Double = 0
        
        // If there are no errors in data, calculate total amount
        if(!errorInData) {
            totalAmountPerPerson = calculateTotalAmount(totalAmount: Double(tipAmount.text!)!, tipPercent: Double(tipPercent.text!)!, totalPeople: Double(totalPeople.text!)!)
            
            getAndSetMessageInUI(totalAmountPerPerson: totalAmountPerPerson)
        } else {
            // If there is error, showing an error message to user
            setErrorMessageInUI()
        }
    }
    
    // This function checks for errors in data submitted by user
    func checkErrorInData(totalAmount: Any, tipPercent: Any, totalPeople: Any) -> Bool {
        var errorInData: Bool = false
        
        // Checking for nil values and setting them to "0.0" (if there are any nil values)
        var totalAmount: Double? = nil
        totalAmount = Double(self.tipAmount.text ?? "0.0")
        var tipPercent: Double? = nil
        tipPercent = Double(self.tipPercent.text ?? "0.0")
        var totalPeople: Double? = nil
        totalPeople = Double(self.totalPeople.text ?? "0.0")
        
        // print("\(type(of: totalAmount)) totalAmount \(totalAmount), \(type(of: tipPercent)) tipPercent \(tipPercent), \(type(of: totalPeople)) totalPeople \(totalPeople), errorInData \(errorInData)")
        
        if(totalAmount == nil || tipPercent == nil || totalPeople == nil || (totalPeople != nil && totalPeople == 0)) {
            errorInData = true
        }
        
        return errorInData
    }
    
    // This function sets default values in the UI
    func setDefaultValuesInUI() -> Void {
        let defaultValues: [String : Double] = [
            "tipAmount": 0.0,
            "tipPercent": 0.0,
            "totalPeople": 0,
            "totalAmountPerPerson": 0.0
        ]
        
        tipAmount.text = String(defaultValues["tipAmount"]!)
        tipPercent.text = String(defaultValues["tipPercent"]!)
        totalPeople.text = String(Int(defaultValues["totalPeople"]!))
        message.text = "\(messagePrefix) \(String(defaultValues["totalAmountPerPerson"]!))"
        
    }
    
    // This function sets the success message that is passed to this function
    func getAndSetMessageInUI(totalAmountPerPerson: Double) -> Void {
        let message = "\(messagePrefix) \(totalAmountPerPerson)"
        self.message.text = message
    }
    
    // This function sets the error message whenever there is an error in input
    func setErrorMessageInUI() -> Void {
        message.text = errorMessage
    }
    
    // This function calculates the total amount of money per person
    func calculateTotalAmount(totalAmount: Double, tipPercent: Double, totalPeople: Double) -> Double {
        var totalAmountPerPerson: Double = 0
        totalAmountPerPerson = (totalAmount + (totalAmount * (tipPercent / 100))) / totalPeople // Core logic of the application
        return totalAmountPerPerson
    }
    
    // StackOverflow: This function is called when the tap is recognized
    @objc func dismissKeyboard() {
        // Causes the view (or one of its embedded text fields) to resign the first responder status
        view.endEditing(true)
    }
    
}

