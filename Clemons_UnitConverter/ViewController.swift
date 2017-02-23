//
//  ViewController.swift
//  Clemons_UnitConverter
//
//  Created by Charles Clemons on 2/6/17.
//  Copyright © 2017 University of Cincinnati. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var units: NSDictionary!
    var unitName: NSArray!
    
    @IBOutlet weak var pickerViewFrom: UIPickerView!
    @IBOutlet weak var pickerViewConvertTo: UIPickerView!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. get a reference to the app bundle
        let appBundle = Bundle.main
        //2. get a reference to the units file path
        let filePath = appBundle.path(forResource: "Units", ofType: "plist")!
        //3. load the file into the units dictionary object
        units = NSDictionary(contentsOfFile: filePath)!
        //4. retrieve the unit names(keys) into the unitNames array object
        unitName = units.allKeys as NSArray!
        unitName = unitName.sorted(by:sortUnitName) as NSArray!
    }
    func sortUnitName(first: Any, second:Any) -> Bool {
        let firstName = first as! String
        let secondName = second as! String
        
        //return firstName<secondName
        
        let conversionFactor1 = units.value(forKey: firstName) as! Float
        let conversionFactor2 = units.value(forKey: secondName) as! Float
        
        return conversionFactor1 < conversionFactor2
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unitName.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return unitName.object(at: row) as? String
    }
    @IBAction func userClickedConvert() {
        convert()
    }
    func convert(){
     //1. retrieve amount enetered in the text field
        let amountAsText=txtAmount.text!
        let numberFormatter=NumberFormatter()
        let amountAsNumber=numberFormatter.number(from: amountAsText)!
        let amount=amountAsNumber.floatValue
        
    //2. retrieve unit the the user selected convert from
        let indexOfUnitToConvertFrom=pickerViewFrom.selectedRow(inComponent: 0)
        let unitNameToConvertFrom=unitName.object(at: indexOfUnitToConvertFrom) as? String
        let conversionFactorToInch=units.value(forKey: unitNameToConvertFrom!) as! Float
        
    //3.convert the amount to inches(first step in two step conversion)
         let amountInInches=amount*conversionFactorToInch
        
    //4.retrieve the unit that the user selected to convert to
        let indexOfUnitToConvertTo=pickerViewConvertTo.selectedRow(inComponent: 0)
        let unitNameToConvertTo=unitName.object(at: indexOfUnitToConvertTo)as? String
        let conversionFactorFromInch=units.value(forKey: unitNameToConvertTo!)as! Float
        let result=amountInInches / conversionFactorFromInch
        
    //5.construct the result message and display in the label
        let resultAsString=String.localizedStringWithFormat("%.6f %@=%.6f %@", amount,unitNameToConvertFrom!, result, unitNameToConvertTo!)
            lblResult.text=resultAsString
        
    //6. dismiss the keyboard
        txtAmount.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

