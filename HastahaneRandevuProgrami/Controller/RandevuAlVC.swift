//
//  RandevuAlVC.swift
//  HastahaneRandevuProgrami
//
//  Created by Can KINCAL on 24.04.2018.
//  Copyright © 2018 Can KINCAL. All rights reserved.
//

import UIKit




class RandevuAlVC: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource{
   
    var selectedRow: String!;
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userType.count;
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userType[row];
    }
    
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedRow = userType[row] as String
        
    }
    

    @IBOutlet weak var randevuBaslangicDatePicker: UIDatePicker!
    
    
    @IBOutlet weak var randevuBitisDatePicker: UIDatePicker!
    
    @IBOutlet weak var polikinlikPickerView: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        polikinlikPickerView.delegate = self;
        polikinlikPickerView.dataSource = self;
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func aramaYapBtnPressed(_ sender: Any) {
        
        
        
        getConfiguredDateForPhpRequest(startDate: randevuBaslangicDatePicker.date, endDate: randevuBitisDatePicker.date)
        
        
    }
    
    
    func getConfiguredDateForPhpRequest(startDate : Date , endDate : Date) {
        let calendar = Calendar.current
        
        let startHour = calendar.component(.hour, from: startDate)
        let startMinutes = calendar.component(.minute, from: startDate)
        let startDay = calendar.component(.day, from: startDate)
        let startMount = calendar.component(.month, from: startDate);
        let startYear = calendar.component(.year, from: startDate);
        
        
       
        
        let endHour = calendar.component(.hour, from: endDate)
        let endMinutes = calendar.component(.minute, from: endDate)
        let endDay = calendar.component(.day, from: endDate)
        let endMount = calendar.component(.month, from: endDate)
        let endYear = calendar.component(.year, from: endDate)
        
        
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
        
         // END DATE STRINGS
        
        
        
        let endMountString = { () -> String in
            if endMount < 10  {
                return "0\(endMount)"
            } else {
                return "\(endMount)"
            }
        }
        
        
        let endDayString = { () -> String in
            if endDay < 10 {
                return "0\(endDay)"
            } else {
                return "\(endDay)";
            }
            
        }
        
        
        let endHourString = { () -> String in
            if endHour < 10 {
                return "0\(endHour)";
            } else {
                return "\(endHour)";
            }
            
        }
        
        let endMinuteString = { () -> String in
            if startMinutes < 10 {
                return "0\(endMinutes)"
            } else {
                return "\(endMinutes)";
            }
            
        }

        let startYearConfigured = "\(startYear)-\(startMountString())-\(startDayString()) \(startHourString()):\(startMinuteString()):00"
        
        
        let endYearConfigured = "\(endYear)-\(endMountString())-\(endDayString()) \(endHourString()):\(endMinuteString()):00"
        
        
        
        
        
        
        
        
        
        
        
        let url = URL(string: "http://localhost/hospital/hastaRandevuAra.php")
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST";
        
        let body = "startDate=\(startYearConfigured)&endDate=\(endYearConfigured)&type=\(selectedRow!)";
        
        print("\(url!)\(body)")
        
        request.httpBody = body.data(using: .utf8)
        
        
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? Array<NSDictionary>
                    
                    for information in json! {
                        var temp = Randevu();
                        
                        temp.doctorId = "\(information.value(forKeyPath: "doctorId")!)"
                        temp.randevuDate = information.value(forKeyPath: "randevuDate") as! String
                        temp.randevuId = "\(information.value(forKey: "randevuId")!)";
                       // temp.doctorId = information["doctorId"] as! String
                        //temp.randevuDate = information["randevuDate"] as! String;
                        randevular.append(temp)
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                } catch {
                    print("Message = \(error)");
                }
            }
        }.resume()

        // 01 Jan 1970 01:33:38
        
        
        performSegue(withIdentifier: "AramaYapBtnClicked", sender: nil)
        
        
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
