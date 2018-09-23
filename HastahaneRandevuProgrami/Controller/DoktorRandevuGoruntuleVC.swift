//
//  DoktorRandevuGoruntuleVC.swift
//  HastahaneRandevuProgrami
//
//  Created by Can KINCAL on 29.04.2018.
//  Copyright © 2018 Can KINCAL. All rights reserved.
//

import UIKit

var doctorRandevular = [Randevu]();

class DoktorRandevuGoruntuleVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctorRandevular.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let randevu = doctorRandevular[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "doktorRandevularimCell") as? doktorRandevularimCell {
            cell.configureCell(randevu: randevu)
            return cell;
        }
        return UITableViewCell();
    }
    
    @IBOutlet weak var randevularTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doctorRandevular.removeAll();
        randevularTableView.delegate = self;
        randevularTableView.dataSource = self;
        
        
        
        let url = URL(string: "http://localhost/hospital/doktorRandevuGoruntule.php")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST";
        
        let body = "doctorId=\(user!["id"]!)";
        
        request.httpBody = body.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? Array<NSDictionary>
                    
                    for information in json! {
                        var temp = Randevu();
                        
                        temp.doctorId = "\(information.value(forKeyPath: "doctorId")!)"
                        temp.randevuDate = information.value(forKeyPath: "randevuDate") as! String
                        temp.randevuId = "\(information.value(forKey: "randevuId")!)";
                        temp.patientId = "\(information.value(forKey: "patientId")!)";
                        // temp.doctorId = information["doctorId"] as! String
                        //temp.randevuDate = information["randevuDate"] as! String;
                        doctorRandevular.append(temp)
                        print(information)
                        DispatchQueue.main.async {
                            self.randevularTableView.reloadData()
                            
                        }
                }
                } catch {
                    print("Error: \(error)")
                }
        }
        
        
        
        
        
        // Do any additional setup after loading the view.
    }.resume()

        
        
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

}
