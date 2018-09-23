//
//  RandevularimVC.swift
//  HastahaneRandevuProgrami
//
//  Created by Can KINCAL on 29.04.2018.
//  Copyright © 2018 Can KINCAL. All rights reserved.
//

import UIKit

var randevularim = [Randevu]();

class RandevularimVC: UIViewController , UITableViewDelegate , UITableViewDataSource{
   
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randevularim.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let randevu = randevularim[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "randevularimCell") as? randevularimCell {
            cell.configureCell(randevu: randevu)
            print("Randevu Created");
            return cell;
        }
        
        return UITableViewCell();
    }
    
    
    
    
    

    @IBOutlet weak var randevularimTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        randevularim.removeAll();
        randevularimTableView.reloadData()
        randevularimTableView.dataSource = self;
        randevularimTableView.delegate = self;
        
        
        let url = URL(string: "http://localhost/hospital/hastaRandevuGoruntule.php")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST";
        
        let body = "patientId=\(user!["id"]!)";
        
        request.httpBody = body.data(using: String.Encoding.utf8)
        
        print("\(url)\(body)")
        
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
                        randevularim.append(temp)
                        print(information)
                        DispatchQueue.main.async {
                            self.randevularimTableView.reloadData()
                            
                        }
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                }catch {
                    print("Error: \(error)");
                }
            }
            }.resume();
        
        
        
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
