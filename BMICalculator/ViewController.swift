//
//  ViewController.swift
//  BMICalculator
//
//  Created by Abdul Rafay on 2024-09-30.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var feetTextField: UITextField!
    @IBOutlet weak var inchTextField: UITextField!
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightMetricTextField: UITextField!

    @IBOutlet weak var weightStandardTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var measurementSegControl: UISegmentedControl!
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBAction func measurementSegControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 { // Metric
            feetTextField.isHidden = true
            inchTextField.isHidden = true
            heightTextField.isHidden = false // Show height in cm
            weightStandardTextField.isHidden = true // Hide standard weight
            weightMetricTextField.isHidden = false // Show metric weight
        } else { // Standard
            heightTextField.isHidden = true // Hide metric height
            feetTextField.isHidden = false // Show feet input
            inchTextField.isHidden = false // Show inches input
            weightStandardTextField.isHidden = false // Show standard weight
            weightMetricTextField.isHidden = true // Hide metric weight
        }
    }

    @IBAction func calculateBMI(_ sender: UIButton) {
        // Initialize variables
        var heightInMeters: Double = 0.0
        var weight: Double = 0.0

        // Validate weight based on the selected system
        if measurementSegControl.selectedSegmentIndex == 0 { // Metric
            guard let weightText = weightMetricTextField.text,
                  let weightMetric = Double(weightText), weightMetric > 0 else {
                resultLabel.text = "Please enter a valid positive weight in kg."
                return
            }
            weight = weightMetric

            // Validate height input
            guard let heightText = heightTextField.text,
                  let height = Double(heightText), height > 0 else {
                resultLabel.text = "Please enter a valid positive height in cm."
                return
            }
            heightInMeters = height / 100 // Convert cm to meters
        } else { // Standard
            guard let weightText = weightStandardTextField.text,
                  let weightStandard = Double(weightText), weightStandard > 0 else {
                resultLabel.text = "Please enter a valid positive weight in lbs."
                return
            }
            weight = weightStandard

            // Validate feet and inches inputs
            guard let feetText = feetTextField.text,
                  let feet = Double(feetText), feet >= 0,
                  let inchesText = inchTextField.text,
                  let inches = Double(inchesText), inches >= 0 else {
                resultLabel.text = "Please enter a valid positive height in feet and inches."
                return
            }
            
            // Convert height to inches and then to meters
            let totalInches = (feet * 12) + inches
            heightInMeters = totalInches * 0.0254 // Convert inches to meters
        }

        // Calculate BMI
        let bmi = weight / (heightInMeters * heightInMeters)
        
        // Get BMI category
        let category = getBMICategory(bmi)
        resultLabel.text = String(format: "Your BMI: %.2f\nCategory: %@", bmi, category)
    }

    func getBMICategory(_ bmi: Double) -> String {
        switch bmi {
        case ..<18.5:
            return "Underweight"
        case 18.5..<24.9:
            return "Normal weight"
        case 25..<29.9:
            return "Overweight"
        default:
            return "Obesity"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        measurementSegControl(measurementSegControl)
        // Do any additional setup after loading the view.
    }


}

