//
//  RegisterVC.swift
//  HastahaneRandevuProgrami
//
//  Created by Can KINCAL on 22.04.2018.
//  Copyright © 2018 Can KINCAL. All rights reserved.
//

import UIKit

var userType = [ "Hasta" , "Genel Cerrahi" , "Göğüs Hastalıkları" , "Kardiyoloji"]

class RegisterVC: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userType.count;
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userType[row];
    }
    
    @IBAction func registerationTypeTextPressed(_ sender: Any) {
        self.registerPickerView.isHidden = false;
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         let selectedRow = userType[row]
        registerTypeTextField.text = selectedRow;
        self.registerPickerView.isHidden = false;
        
    }
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var registerPickerView: UIPickerView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registerTypeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        
        registerPickerView.delegate = self;
        registerPickerView.dataSource = self;
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        registerPickerView.isHidden = true;
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    @IBAction func kayitOlBtnPressed(_ sender: Any) {
        if fullNameTextField.text!.isEmpty || passwordTextField.text!.isEmpty || emailTextField.text!.isEmpty || fullNameTextField.text!.isEmpty || registerTypeTextField.text!.isEmpty {
            print("got empty fileds")
            return;
        } else {
            // Create new user in mysql
            print("making http request")
            let url = NSURL(string: "http://localhost/hospital/register.php")!;
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST";
            let body = "username=\(usernameTextField.text!.lowercased())&password=\(passwordTextField.text!)&type=\(registerTypeTextField.text!)&email=\(emailTextField.text!)&fullname=\(fullNameTextField.text!)"
            
            request.httpBody = body.data(using: String.Encoding.utf8)
            
            
            URLSession.shared.dataTask(with: request as URLRequest) { (data, request, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            guard let parseJSON = json else {
                                print("Erorr while parsing");
                                return;
                            }
                            
                            let id = parseJSON["id"];
                            
                            if id != nil {
                                print(parseJSON);
                                UserDefaults.standard.set(parseJSON , forKey:"parseJSON");
                                user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary;
                                
                            }
                            
                            
                        } catch {
                            print("Caught an error \(error)");
                        }
                    }
                } else {
                    print("error \(error)")
                }
            }.resume()
            
            
            
            
            
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
