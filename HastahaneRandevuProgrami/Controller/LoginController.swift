//
//  ViewController.swift
//  HastahaneRandevuProgrami
//
//  Created by Can KINCAL on 10.04.2018.
//  Copyright © 2018 Can KINCAL. All rights reserved.
//

import UIKit




class LoginController: UIViewController {
    @IBOutlet weak var doctorImg: UIImageView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var ruDoctorSegmentedController: UISegmentedControl!
    
    var imgListForAnimate: Array<UIImage> = Array<UIImage>();
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        for i in 1...5 {
//
//            guard let image = UIImage(named: "doctor-\(i).jpg") else {
//                print(" Image \(i) Cannot Find")
//                return;
//            }
//            imgListForAnimate.append(image)
//
//        }
//
//        self.doctorImg.animationImages = imgListForAnimate;
//        self.doctorImg.animationDuration = 5.0;
//        self.doctorImg.startAnimating()
//
        
        
        doctorImg.isHidden = true;
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        
        print("function ")
        guard let userName = userNameTextField.text else {
            print("userName cannot be null");
            return
        }
        guard let password = passwordTextField.text else {
            print("password cannot be null")
            return
        }
        
        
        
        
        
        if userName != "" && password != "" {
            
            let url = NSURL(string: "http://localhost/hospital/login.php")!;
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST";
            var type: String;
            if ruDoctorSegmentedController.selectedSegmentIndex == 1 {
                type = "Hasta";
                
            } else {
                type = "doctor";
            }
            
            
            
            let body = "username=\(userName)&password=\(password)&type=\(type)";
            
            
            print(body)
            
            request.httpBody = body.data(using: String.Encoding.utf8)
            URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                if error == nil {
                    print("error is nil ")
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        guard let parseJSON = json else {
                            print("Error While parsing");
                            return
                        }
                        
                        print("parsed");
                        
                        print(parseJSON)
                        
                        let id = parseJSON["id"] as? String
                        let status = parseJSON["status"] as? String
                        let message = parseJSON["message"] as? String
                        
                        
                        
                        
                            // SAVE USER INFORMATION RECEIVED FROM HOST
                        
                        
                        if id != nil {
                            
                            UserDefaults.standard.set(parseJSON , forKey: "parseJSON");
                            user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary;
                            DispatchQueue.main.async {
                           
                                if user!["userType"] as! String == "Hasta" {
                                    
                                    print("Performing segue")
                                    self.performSegue(withIdentifier: "userLogeedIn", sender: nil)
                                } else if user!["userType"] as! String != "Hasta" {
                                    self.performSegue(withIdentifier: "doctorLoggedIn", sender: nil)
                                }
                                
                            }
                            
                           
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                        
                    } catch {
                        print("Caught an error: \(error)");
                        return;
                    }
                } else {
                    print("Eror while request")
                    return;
                }
            }.resume()
            
            
            
            
            
        } else {
            print("username or password is empty")
            return;
        }
 
        
        
        
        
    }
    
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "registerSegue", sender: nil)
    }
    
}

