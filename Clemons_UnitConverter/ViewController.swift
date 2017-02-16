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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

