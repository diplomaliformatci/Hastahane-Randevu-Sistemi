//
//  patientMainVC.swift
//  HastahaneRandevuProgrami
//
//  Created by Can KINCAL on 24.04.2018.
//  Copyright © 2018 Can KINCAL. All rights reserved.
//

import UIKit

class patientMainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func randevuAlBtnPressed(_ sender: Any) {
        print("Performing Randevu Al Segue")
        performSegue(withIdentifier: "randevuAlSegue", sender: nil)
        
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//
//        let RandevuAlVC = storyBoard.instantiateViewController(withIdentifier: "randevuAlVC");
//
//        present(RandevuAlVC, animated: true, completion: nil)
//
        
    }
    
    @IBAction func receteGoruntuleBtnPressed(_ sender: Any) {
    }
    
    @IBAction func randevulariGoruntuleBtnPressed(_ sender: Any) {
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
