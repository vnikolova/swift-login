//
//  LoginViewController.swift
//  LogIn
//
//  Created by admin on 01/10/16.
//  Copyright © 2016 Vik Nikolova. All rights reserved.
//

import UIKit
import CloudKit

class LoginViewController: UIViewController {
    //set up db
    var db:CKDatabase!
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        //connect db
        db = CKContainer.default().publicCloudDatabase
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        let userEmail = userEmailTextField.text!;
        let userPassword = userPasswordTextField.text!;
        
        //check for empty fields
        if ((userEmail.isEmpty) || (userPassword.isEmpty)){
            //display alert
            let myAlert = UIAlertController(title:"Uh-oh!", message: "All fields are required.", preferredStyle: UIAlertControllerStyle.alert);
            let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil);
            
            myAlert.addAction(okAction);
            
            self.present(myAlert, animated: true, completion: nil);
        }
        else {
            //check if correct
            let predicate = NSPredicate(format: "email == %@ AND password == %@", argumentArray: [userEmail, userPassword])
            
            let query = CKQuery(recordType: "myUsers", predicate: predicate)
            db.perform(query, inZoneWith: nil) { (records:[CKRecord]?, error:Error?) in
                if error == nil {
                    if (records?.count)! > 0
                    {
                        let record = records?[0]
                        let email = (record?.value(forKey: "email"))!
                        //add user defaults for logged in
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                        UserDefaults.standard.synchronize()
                        print("Found user: \(email)")
                        
                        //redirect to main view
                        self.dismiss(animated: true, completion: nil)
                        
                    } else {
                        print("no such user found. Don't give up.")
                    }
                } else
                {
                    print(error)
                }
            }

        }
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
