//
//  RandevularVC.swift
//  HastahaneRandevuProgrami
//
//  Created by Can KINCAL on 28.04.2018.
//  Copyright © 2018 Can KINCAL. All rights reserved.
//

import UIKit
var randevular = [Randevu]();

var selectedRandevu: Randevu!;

class RandevularVC: UIViewController  , UITableViewDelegate , UITableViewDataSource{
    @IBOutlet weak var randevuTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randevular.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Randevular going HERE
        
        let randevu = randevular[indexPath.row]
        
        if let cell = randevuTableView.dequeueReusableCell(withIdentifier: "randevuCell") as? randevuCell {
            cell.configureCell(randevu: randevu)
            
            print("Cell Created");
            return cell;
        }
        
        return UITableViewCell();
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRandevu = randevular[indexPath.row];
        
        print(selectedRandevu.randevuDate);
        
        if let randevuId = selectedRandevu.randevuId {
        
        print("Randevu ID = \(randevuId)")
        randevuIstegiGonder(selectedRandevuId: randevuId);
            
            
        }
        
        
//        performSegue(withIdentifier: "AramaYapBtnClicked", sender: nil)
        
        
        
        
        
        
        
        return;
    }
    
    
    func randevuIstegiGonder(selectedRandevuId: String?) {
        //http://localhost/hospital/hastaRandevuAl.php?randevuId=1953&patientId=15
        let url = URL(string: "http://localhost/hospital/hastaRandevuAl.php")!
        var request = URLRequest(url: url)
        
        request.httpMethod =  "POST";
        
        
        
        let body = "randevuId=\(selectedRandevuId!)&patientId=\(user!["id"]!)"
        
        print(body);
        
        request.httpBody = body.data(using: String.Encoding.utf8)
        
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    guard let parseJSON = json else {
                        print("Error While PArsing")
                        return;
                    }
                    
                    
                    
                    
                    
                    
                }catch {
                    return;
                }
            }
            }.resume();
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    

    override func viewDidAppear(_ animated: Bool) {
        randevuTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randevuTableView.delegate = self
        randevuTableView.dataSource = self;
        
        print(randevular);
        
        print("I am Here")
        

    
        
        
    }
    
    
    func refresh() {
        randevuTableView.reloadData();
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
    @IBAction func randevuTakipEtBtnPressed(_ sender: Any) {
        
    }
    
}
