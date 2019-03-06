//
//  settingsController.swift
//  Tindents
//
//  Created by Meriem Bounab on 2/6/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController {
    var settingsArr = ["oncSwitchOn":0, "offcSwitchOn":0, "fsSwitchOn":0, "jsSwitchOn":0, "cheapSwitchOn":0, "medSwitchOn":0, "expensiveSwitchOn":0, "comSwitchOn":0, "csSwitchOn":0, "bioSwitchOn":0, "econSwitchOn":0, "chemSwitchOn":0, "englishSwitchOn":0, "physicsSwitchOn":0, "mathSwitchOn":0,]
    
    var oncSwitchOn = false;
    var offcSwitchOn = false;
    var fsSwitchOn = false;
    var jsSwitchOn = false;
    var cheapSwitchOn = false;
    var medSwitchOn = false;
    var expensiveSwitchOn = false;
    var comSwitchOn = false;
    var csSwitchOn = false;
    var bioSwitchOn = false;
    var econSwitchOn = false;
    var chemSwitchOn = false;
    var englishSwitchOn = false;
    var physicsSwitchOn = false;
    var mathSwitchOn = false;

    @IBAction func comSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            comSwitchOn=true;
            settingsArr["comSwitch"] = 1
        }
        else{
            comSwitchOn=false;
            settingsArr["comSwitch"] = 0
        }
    }
    @IBAction func csSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            csSwitchOn=true;
            settingsArr["csSwitchOn"] = 1
        }
        else{
            csSwitchOn=false;
            settingsArr["csSwitchOn"] = 0
        }
    }
    @IBAction func bioSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            bioSwitchOn=true;
            settingsArr["bioSwitchOn"] = 1
        }
        else{
            bioSwitchOn=false;
            settingsArr["bioSwitchOn"] = 0
        }
    }
    @IBAction func econSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            econSwitchOn=true;
            settingsArr["econSwitchOn"] = 1
        }
        else{
            econSwitchOn=false;
            settingsArr["econSwitchOn"] = 0
        }
    }
    @IBAction func chemSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            chemSwitchOn=true;
            settingsArr["chemSwitchOn"] = 1
        }
        else{
            chemSwitchOn=false;
            settingsArr["chemSwitchOn"] = 0
        }
    }
    @IBAction func englishSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            englishSwitchOn=true;
            settingsArr["englishSwitchOn"] = 1
        }
        else{
            englishSwitchOn=false;
            settingsArr["englishSwitchOn"] = 0
        }
    }
    @IBAction func physicsSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            physicsSwitchOn=true;
            settingsArr["physicsSwitchOn"] = 1
        }
        else{
            physicsSwitchOn=false;
            settingsArr["physicsSwitchOn"] = 0
        }
    }
    @IBAction func mathSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            mathSwitchOn=true;
            settingsArr["mathSwitchOn"] = 1
        }
        else{
            mathSwitchOn=false;
            settingsArr["mathSwitchOn"] = 0
        }
    }
    @IBAction func expensiveSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            expensiveSwitchOn=true;
            settingsArr["expensiveSwitchOn"] = 1
        }
        else{
            expensiveSwitchOn=false;
            settingsArr["expensiveSwitchOn"] = 0
        }
    }
    @IBAction func medSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            medSwitchOn=true;
            settingsArr["medSwitchOn"] = 1
        }
        else{
            medSwitchOn=false;
            settingsArr["medSwitchOn"] = 0
        }
    }
    @IBAction func cheapSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            cheapSwitchOn=true;
            settingsArr["cheapSwitchOn"] = 1
        }
        else{
            cheapSwitchOn=false;
            settingsArr["cheapSwitchOn"] = 0
        }
    }
    @IBAction func jSSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            jsSwitchOn=true;
            settingsArr["jsSwitchOn"] = 1
        }
        else{
            jsSwitchOn=false;
            settingsArr["jsSwitchOn"] = 0
        }
    }
    @IBAction func fSSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            fsSwitchOn=true;
            settingsArr["fsSwitchOn"] = 1
        }
        else{
            fsSwitchOn=false;
            settingsArr["fsSwitchOn"] = 0
        }
    }
    @IBAction func offCSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            offcSwitchOn=true;
            settingsArr["comSwitch"] = 1
        }
        else{
            offcSwitchOn=false;
            settingsArr["comSwitch"] = 1
        }
    }
    @IBAction func onCSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            oncSwitchOn=true;
            settingsArr["comSwitch"] = 1
        }
        else{
            oncSwitchOn=false;
            settingsArr["comSwitch"] = 1
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func updateBtn(_ sender: Any) {
        requests().updateSettingsRequest(dict:settingsArr) { (response) in
            if let response = response {
                
                var success = response["success"] as? Int
                if success == 1 {
                    print("SUCCESS")
                } else {
                    print("FAILURE")
                }
            }
        }
    }
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
}
