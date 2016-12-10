//
//  RegisterPageViewController.swift
//  LogIn
//
//  Created by admin on 01/10/16.
//  Copyright © 2016 Vik Nikolova. All rights reserved.
//

import UIKit
import CloudKit

class RegisterPageViewController: UIViewController {
    var db:CKDatabase!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatpasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        db = CKContainer.default().publicCloudDatabase

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerBtnClick(_ sender: AnyObject) {
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        let repeatPassword = repeatpasswordTextField.text;

        
        //check empty fields
        if ((userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (repeatPassword?.isEmpty)!) {
            
            //display alert message
            displayAlert(message: "All fields are required.");
            return;
        }
        
        //check if passwords match
        if (userPassword != repeatPassword) {
            //display alert message
            displayAlert(message: "Passwords do not match.");
        } else {
        
            let record = CKRecord(recordType: "myUsers")
            record.setValue(userEmail, forKey: "email")
            record.setValue(userPassword, forKey: "password")
            db.save(record) { (record:CKRecord?, error:Error?) in
                // 4. update GUI
                if error == nil {
                    print("registered")

                } else {
                    print("error: \(error)")
                }
            }
        }
        
    }
    
    func displayAlert(message: String){
        let myAlert = UIAlertController(title:"Alert", message: message, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
    }

   

}
