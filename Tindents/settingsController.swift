//
//  settingsController.swift
//  Tindents
//
//  Created by Meriem Bounab on 2/6/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController {
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
        }
        else{
            comSwitchOn=false;
        }
    }
    @IBAction func csSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            csSwitchOn=true;
        }
        else{
            csSwitchOn=false;
        }
    }
    @IBAction func bioSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            bioSwitchOn=true;
        }
        else{
            bioSwitchOn=false;
        }
    }
    @IBAction func econSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            econSwitchOn=true;
        }
        else{
            econSwitchOn=false;
        }
    }
    @IBAction func chemSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            chemSwitchOn=true;
        }
        else{
            chemSwitchOn=false;
        }
    }
    @IBAction func englishSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            englishSwitchOn=true;
        }
        else{
            englishSwitchOn=false;
        }
    }
    @IBAction func physicsSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            physicsSwitchOn=true;
        }
        else{
            physicsSwitchOn=false;
        }
    }
    @IBAction func mathSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            mathSwitchOn=true;
        }
        else{
            mathSwitchOn=false;
        }
    }
    @IBAction func expensiveSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            expensiveSwitchOn=true;
        }
        else{
            expensiveSwitchOn=false;
        }
    }
    @IBAction func medSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            medSwitchOn=true;
        }
        else{
            medSwitchOn=false;
        }
    }
    @IBAction func cheapSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            cheapSwitchOn=true;
        }
        else{
            cheapSwitchOn=false;
        }
    }
    @IBAction func jSSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            jsSwitchOn=true;
        }
        else{
            jsSwitchOn=false;
        }
    }
    @IBAction func fSSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            fsSwitchOn=true;
        }
        else{
            fsSwitchOn=false;
        }
    }
    @IBAction func offCSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            offcSwitchOn=true;
        }
        else{
            offcSwitchOn=false;
        }
    }
    @IBAction func onCSwitch(sender: UISwitch) {
        if(sender.isOn==true){
            oncSwitchOn=true;
        }
        else{
            oncSwitchOn=false;
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
