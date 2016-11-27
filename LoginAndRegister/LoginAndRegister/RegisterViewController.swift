//
//  RegisterViewController.swift
//  LoginAndRegister
//
//  Created by admin on 22/11/2016.
//  Copyright © 2016 Vik Nikolova. All rights reserved.
//

import UIKit
import CloudKit

class RegisterViewController: UIViewController {

    var db:CKDatabase!
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = CKContainer.default().publicCloudDatabase
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        let userRepeatPassword = repeatPasswordTextField.text
        
        //check for empty fields
        if((userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (userRepeatPassword?.isEmpty)!) {
            //display alert message
            displayMessage(userMessage: "All fields are required.");
            return;
        }
        
        //check if passwords match
        if(userPassword != userRepeatPassword) {
            //display alert message
            displayMessage(userMessage: "Passwords do not match.")
            return
        }
        
        //store data
        // 1. create CKRecord
        let record = CKRecord(recordType: "MyUsers")
        // 2. add data to it
        record.setValue(userEmail, forKey: "email")
        record.setValue(userPassword, forKey: "password")
        // 3. send to iCloud
        db.save(record) { (record:CKRecord?, error:Error?) in
            // 4. update GUI
            if error == nil {
                
                print("finished successfully")
            } else {
                
                print("error: \(error)")
            }
        //display alert message with confirmation
 }
}

    func displayMessage(userMessage: String) {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
