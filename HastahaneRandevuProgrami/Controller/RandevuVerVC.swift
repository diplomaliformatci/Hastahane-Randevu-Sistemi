//
//  RandevuVerVC.swift
//  HastahaneRandevuProgrami
//
//  Created by Can KINCAL on 28.04.2018.
//  Copyright © 2018 Can KINCAL. All rights reserved.
//

import UIKit


struct randevuTime {
    let username: String;
    let password: String;
    let startDate: String;
    let endDate: String;
    let type: String;
}



class RandevuVerVC: UIViewController {
    @IBOutlet weak var randevuBaslangicDatePicker: UIDatePicker!
    @IBOutlet weak var randevuBitisDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func calismaSaatleriniOnaylaBtnPressed(_ sender: Any) {
        
        var startDate  = randevuBaslangicDatePicker.date;
        let calendar = Calendar.current
        var startHour = calendar.component(.hour, from: startDate)
        var startMinutes = calendar.component(.minute, from: startDate)
        var startDay = calendar.component(.day, from: startDate)
        var startMount = calendar.component(.month, from: startDate);
        var startYear = calendar.component(.year, from: startDate);
        
        
        
        var endDate = randevuBitisDatePicker.date;
        
        
        
        
        let endHour = calendar.component(.hour, from: endDate);
        let endMinutes = calendar.component(.minute, from: endDate);
        let endDay = calendar.component(.day, from: endDate);
        let endMount = calendar.component(.month, from: endDate)
        let endYear = calendar.component(.year, from: endDate);
        
        
        print("Here")
        while (endDay != startDay || endMount != startMount || endMinutes != startMinutes || endHour != startHour) {
            
            print("Here 2");
            
            
            startMinutes = startMinutes + 15;
            
            if startMinutes >= 59 {
                startMinutes = 0;
                startHour = startHour + 1;
            }
            
            if startHour == 24 {
                startHour = 0 ;
                startDay = startDay + 1;
            }
            
            if startDay == 30 {
                startDay = 1 ;
                startMount = startMount + 1;
            }
            
            
            
            let startMountString = { () -> String in
                if startMount < 10  {
                    return "0\(startMount)"
                } else {
                    return "\(startMount)"
                }
            }
            
            
            let startDayString = { () -> String in
                if startDay < 10 {
                    return "0\(startDay)"
                } else {
                    return "\(startDay)";
                }
                
            }
            
            
            let startHourString = { () -> String in
                if startHour < 10 {
                    return "0\(startHour)";
                } else {
                    return "\(startHour)";
                }
                
            }
            
            let startMinuteString = { () -> String in
                if startMinutes < 10 {
                    return "0\(startMinutes)"
                } else {
                    return "\(startMinutes)";
                }
                
            }
            
            
            
            
            let Year = "\(startYear)-\(startMountString())-\(startDayString()) \(startHourString()):\(startMinuteString()):00"
            
            
            
            if (startHour < 17 && startHour > 7) {
            sendUrlRequest(date: Year);
            }
            
            
            
            print("\(startYear)-\(startMountString())-\(startDayString()) \(startHourString()):\(startMinuteString()):00");
            
            
            
            
            
            
            
            

            
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    func sendUrlRequest(date : String) {
        let url = URL(string: "http://localhost/hospital/doktorRandevuVer.php")
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST";
        
        let body = "username=\(user!["username"]!)&startDate=\(date)&type=\(user!["userType"]!)";
        
        print("\(url)?\(body)")
        
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                do {
                    let json  = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    guard let parseJSON = json else {
                        print("Error while parsing")
                        return;
                    }
                    
                    
                    
                    let id = parseJSON["id"] as? String
                    
                    if id != nil {
                        print(parseJSON);
                    }
                    
                } catch {
                    print("Message = \(error)")
                }
            }
        }.resume()
        
        
        
        
        
    }
    
    
    
}
