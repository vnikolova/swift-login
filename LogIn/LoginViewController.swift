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
        
        //check if correct
        let predicate = NSPredicate(format: "email == %@ AND password == %@", argumentArray: [userEmail, userPassword])
        
        let query = CKQuery(recordType: "myUsers", predicate: predicate)
        db.perform(query, inZoneWith: nil) { (records:[CKRecord]?, error:Error?) in
            if error == nil {
                if (records?.count)! > 0
                {
                    let record = records?[0]
                    let email = (record?.value(forKey: "email"))!
                    print("Found user: \(email)")
                } else {
                    print("no such user found. Don't give up.")
                }
            } else
            {
                print(error)
            }
        }
        //redirect to main page
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
