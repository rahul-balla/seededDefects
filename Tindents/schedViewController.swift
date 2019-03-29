//
//  schedViewController.swift
//  Tindents
//
//  Created by Meriem Bounab on 3/10/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import UIKit

class schedViewController: UIViewController, UITextFieldDelegate{
    //Sunday
    @IBOutlet weak var textField_Date: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var sSwitch: UISwitch!
    
    //Monday
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var mSwitch: UISwitch!
    //Tuesday
    @IBOutlet weak var textField5: UITextField!
    @IBOutlet weak var textField6: UITextField!
    @IBOutlet weak var tSwitch: UISwitch!
    //Wednesday
    @IBOutlet weak var textField7: UITextField!
    @IBOutlet weak var textField8: UITextField!
    @IBOutlet weak var wSwitch: UISwitch!
    //Thursday
    @IBOutlet weak var textField9: UITextField!
    @IBOutlet weak var textField10: UITextField!
    @IBOutlet weak var thSwitch: UISwitch!
    //Friday
    @IBOutlet weak var textField11: UITextField!
    @IBOutlet weak var textField12: UITextField!
    @IBOutlet weak var fSwitch: UISwitch!
    //Saturday
    @IBOutlet weak var textField13: UITextField!
    @IBOutlet weak var textField14: UITextField!
    @IBOutlet weak var saSwitch: UISwitch!
    
    
    var temptf : UITextField!
    var datePicker : UIDatePicker!
    var availabile : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField_Date.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        textField4.delegate = self
        textField5.delegate = self
        textField6.delegate = self
        textField7.delegate = self
        textField8.delegate = self
        textField9.delegate = self
        textField10.delegate = self
        textField11.delegate = self
        textField12.delegate = self
        textField13.delegate = self
        textField14.delegate = self
        
        textField_Date.isHidden = true
        textField2.isHidden = true
        textField3.isHidden = true
        textField4.isHidden = true
        textField5.isHidden = true
        textField6.isHidden = true
        textField7.isHidden = true
        textField8.isHidden = true
        textField9.isHidden = true
        textField10.isHidden = true
        textField11.isHidden = true
        textField12.isHidden = true
        textField13.isHidden = true
        textField14.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sToggle(_ sender: Any) {
        if(sSwitch.isOn){
            textField_Date.isHidden = false
            textField2.isHidden = false
        }
        else{
            textField_Date.isHidden = true
            textField2.isHidden = true
        }
    }
    @IBAction func mToggle(_ sender: Any) {
        if(mSwitch.isOn){
            textField3.isHidden = false
            textField4.isHidden = false
        }
        else{
            textField3.isHidden = true
            textField4.isHidden = true
        }
    }
    @IBAction func tToggle(_ sender: Any) {
        if(tSwitch.isOn){
            textField5.isHidden = false
            textField6.isHidden = false
        }
        else{
            textField5.isHidden = true
            textField6.isHidden = true
        }
    }
    @IBAction func wToggle(_ sender: Any) {
        if(wSwitch.isOn){
            textField7.isHidden = false
            textField8.isHidden = false
        }
        else{
            textField7.isHidden = true
            textField8.isHidden = true
        }
    }
    @IBAction func thToggle(_ sender: Any) {
        if(thSwitch.isOn){
            textField9.isHidden = false
            textField10.isHidden = false
        }
        else{
            textField9.isHidden=true
            textField10.isHidden=true
        }
    }
    
    @IBAction func fToggle(_ sender: Any) {
        if(fSwitch.isOn){
            textField11.isHidden=false
            textField12.isHidden=false
        }
        else{
            textField11.isHidden=true
            textField12.isHidden=true
        }
    }
    
    @IBAction func saToggle(_ sender: Any) {
        if(saSwitch.isOn){
            textField13.isHidden=false
            textField14.isHidden=false
        }
        else{
            textField13.isHidden=true
            textField14.isHidden=true
        }
    }
    
    
    //MARK:- textFiled Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField.tag == 1){
            temptf = textField_Date
            self.pickUpDate(self.textField_Date)
        }
        else if(textField.tag == 2){
            temptf = textField2
            self.pickUpDate(self.textField2)
        }
        else if(textField.tag == 3){
            temptf = textField3
            self.pickUpDate(self.textField3)
        }
        else if(textField.tag == 4){
            temptf = textField4
            self.pickUpDate(self.textField4)
        }
        else if(textField.tag == 5){
            temptf = textField5
            self.pickUpDate(self.textField5)
        }
        else if(textField.tag == 6){
            temptf = textField6
            self.pickUpDate(self.textField6)
        }
        else if(textField.tag == 7){
            temptf = textField7
            self.pickUpDate(self.textField7)
        }
        else if(textField.tag == 8){
            temptf = textField8
            self.pickUpDate(self.textField8)
        }
        else if(textField.tag == 9){
            temptf = textField9
            self.pickUpDate(self.textField9)
        }
        else if(textField.tag == 10){
            temptf = textField10
            self.pickUpDate(self.textField10)
        }
        else if(textField.tag == 11){
            temptf = textField11
            self.pickUpDate(self.textField11)
        }
        else if(textField.tag == 12){
            temptf = textField12
            self.pickUpDate(self.textField12)
        }
        else if(textField.tag == 13){
            temptf = textField13
            self.pickUpDate(self.textField13)
        }
        else if(textField.tag == 14){
            temptf = textField14
            self.pickUpDate(self.textField14)
        }
        
    }
    
    //MARK:- Function of datePicker
    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = UIDatePicker.Mode.time
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(schedViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(schedViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    // MARK:- Button Done and Cancel
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .none
        dateFormatter1.timeStyle = .short
        temptf.text = dateFormatter1.string(from: datePicker.date)
        temptf.resignFirstResponder()
        var isValid = true
        if((temptf.tag == 2 && textField_Date.text != "") || (temptf.tag==1 && textField2.text != "")){
            isValid = checkTime(textField_Date, textField2)
        }
        else if((temptf.tag==3 && textField4.text != "") || (temptf.tag==4 && textField3.text != "")){
            isValid = checkTime(textField3, textField4)
        }
        else if((temptf.tag==5 && textField6.text != "") || (temptf.tag==6 && textField5.text != "")){
            isValid = checkTime(textField5,  textField6)
        }
        else if((temptf.tag==7 && textField8.text != "") || (temptf.tag==8 && textField7.text != "")){
            isValid = checkTime(textField7,  textField8)
        }
        else if((temptf.tag==9 && textField10.text != "") || (temptf.tag==10 && textField9.text != "")){
            isValid = checkTime(textField9, textField10)
        }
        else if((temptf.tag==11 && textField12.text != "") || (temptf.tag==12 && textField11.text != "")){
            isValid = checkTime(textField11, textField12)
        }
        else if((temptf.tag==13 && textField14.text != "") || (temptf.tag==14 && textField13.text != "")){
            isValid = checkTime(textField13, textField14)
        }
        
        if(isValid == false){
            let alert = UIAlertController(title: "Invalid time period", message: "The end time was earlier than the start time", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
        }
    }
    
    func checkTime(_ textField1: UITextField , _ textField2: UITextField) -> Bool{
        let original2 = textField2.text?.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
        let timeString2 = original2![0].split(separator: ":", maxSplits: 1, omittingEmptySubsequences: true)
        
        var hour2 = Int(timeString2[0])
        if(textField2.text?.hasSuffix("PM") ?? false){
            hour2 = hour2! + 12
        }
        let min2 = Int(timeString2[1])
        let eTime = hour2!*100 + min2!
        //print(eTime as Any)
        let original1 = textField1.text?.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
        let timeString1 = original1![0].split(separator: ":", maxSplits: 1, omittingEmptySubsequences: true)
        
        var hour1 = Int(timeString1[0])
        if(textField1.text?.hasSuffix("PM") ?? false){
            hour1 = hour1! + 12
        }
        let min1 = Int(timeString1[1])
        let sTime = hour1!*100 + min1!
        //print(sTime as Any)
        
        if(sTime < eTime){
            return true
        }
        else{
            textField1.text = ""
            textField2.text = ""
            return false
        }
        
    }
    
    @objc func cancelClick() {
        temptf.resignFirstResponder()
    }
    
    @IBAction func finishSched(_ sender: Any) {
        availabile=""
        if(sSwitch.isOn && textField_Date.text != "" && textField2.text != ""){
            availabile.append("SUN ")
            availabile.append(textField_Date.text!)
            availabile.append(" to ")
            availabile.append(textField2.text!)
            availabile.append(",")
        }
        if(mSwitch.isOn && textField3.text != "" && textField4.text != ""){
            availabile.append("MON ")
            availabile.append(textField3.text!)
            availabile.append(" to ")
            availabile.append(textField4.text!)
            availabile.append(",")
        }
        if(tSwitch.isOn && textField5.text != "" && textField6.text != ""){
            availabile.append("TUES ")
            availabile.append(textField5.text!)
            availabile.append(" to ")
            availabile.append(textField6.text!)
            availabile.append(",")
        }
        if(wSwitch.isOn && textField7.text != "" && textField8.text != ""){
            availabile.append("WED ")
            availabile.append(textField7.text!)
            availabile.append(" to ")
            availabile.append(textField8.text!)
            availabile.append(",")
        }
        if(thSwitch.isOn && textField9.text != "" && textField10.text != ""){
            availabile.append("THURS ")
            availabile.append(textField9.text!)
            availabile.append(" to ")
            availabile.append(textField10.text!)
            availabile.append(",")
        }
        if(fSwitch.isOn && textField11.text != "" && textField12.text != ""){
            availabile.append("FRI ")
            availabile.append(textField11.text!)
            availabile.append(" to ")
            availabile.append(textField12.text!)
            availabile.append(",")
        }
        if(saSwitch.isOn && textField13.text != "" && textField14.text != ""){
            availabile.append("SAT ")
            availabile.append(textField13.text!)
            availabile.append(" to ")
            availabile.append(textField14.text!)
            availabile.append(",")
            
        }
        
        if (availabile.count > 0) {
            availabile.remove(at: availabile.lastIndex(of: ",")!)
            
            print("the schedule is " + availabile!)
            requests().schedulerRequest(schedulerString: availabile) { (response) in
                if let response = response {
                    print("scheduler response: \(response)")
                    /*var success = response["success"] as? Int
                     if success == 1 {
                     print("SUCCESS")
                     } else {
                     print("FAILURE")
                     }*/
                }
            }
        } else {
            print("Nothing updated")
        }
        
    }
}

