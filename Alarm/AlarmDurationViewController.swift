//
//  AlarmDurationViewController.swift
//  Alarm
//
//  Created by Varun Naharia on 29/03/18.
//  Copyright © 2018 DevMountain. All rights reserved.
//

import UIKit

class AlarmDurationViewController: UIViewController {

    @IBOutlet weak var txtAlarmDuration: UITextField!
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet var picker: UIPickerView!
    var data:[[String:Any]] = [["Text":"30 min","Value":30], ["Text":"1 Hour ","Value":60], ["Text":"3 Hour","Value":180]]
    var selectedTime:Int = 30
    override func viewDidLoad() {
        super.viewDidLoad()
        txtAlarmDuration.inputView = picker
        picker.delegate = self
        picker.dataSource = self
        txtAlarmDuration.inputAccessoryView = toolbar
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        txtAlarmDuration.resignFirstResponder()
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        txtAlarmDuration.text = data[picker.selectedRow(inComponent: 0)]["Text"] as? String
        selectedTime = (data[picker.selectedRow(inComponent: 0)]["Value"] as? Int)!
    }
}

extension AlarmDurationViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]["Text"] as? String
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
    }
    
//    func addDoneButtonOnKeyboard()
//    {
//        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
//        doneToolbar.barStyle = UIBarStyle.blackTranslucent
//        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.doneButtonAction))
//        var items:[UIBarButtonItem] = []
//        items.append(done)
//        doneToolbar.items = items
//        doneToolbar.sizeToFit()
//        self.txtAlarmDuration.inputAccessoryView = doneToolbar
//    }
    
    @objc func doneButtonAction()
    {
        
        txtAlarmDuration.text = data[picker.selectedRow(inComponent: 0)]["Text"] as? String
        self.txtAlarmDuration.resignFirstResponder()
    }
}
