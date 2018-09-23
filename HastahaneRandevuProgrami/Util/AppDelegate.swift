//
//  AppDelegate.swift
//  HastahaneRandevuProgrami
//
//  Created by Can KINCAL on 10.04.2018.
//  Copyright © 2018 Can KINCAL. All rights reserved.
//

import UIKit

var user: NSDictionary?


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var backgroundImg = UIImageView();
    var i = 1;
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window!.backgroundColor = UIColor.white
        
        backgroundImg.frame = CGRect(x: 0, y: 0, width: self.window!.bounds.height * 1.444, height: self.window!.bounds.height)
        backgroundImg.image = UIImage(named: "doctor-1");
        backgroundImg.contentMode = .scaleAspectFill
        backgroundImg.isHidden = false;
        //print("Image Loaded");
        self.window!.addSubview(backgroundImg)
        
        findTypes();
        downAlphaForBackgroundImg()
//        self.recursiveChangeBackgroundWithAnimation()
        
        
        
        
        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary;
        
        
        
        
        if user != nil {
            let id = user!["id"] as? String;
            if id != nil {
                print("id is in theere");
            }
        }
        
        
        
        return true
    }
    
    
    func downAlphaForBackgroundImg() {
        
        backgroundImg.frame = CGRect(x: 0, y: 0, width: self.window!.bounds.height * 1.444, height: self.window!.bounds.height)
        backgroundImg.contentMode = .scaleAspectFill
        backgroundImg.alpha = 1;
      //  print("image alpha up ImageAlpha: \(backgroundImg.alpha)")
        UIView.animate(withDuration: 2, animations: {
            
            self.backgroundImg.alpha = 0;
        }) { (finished) in
            if finished {
                self.upAlphaForBackgroundImg()
            }
        }
    }
    
    func upAlphaForBackgroundImg() {
        if (i == 5) {
            i = 1;
        }
        
        i = self.i + 1;
        
        backgroundImg.image = UIImage(named: "doctor-\(i)")
        
        backgroundImg.frame = CGRect(x: 0, y: 0, width: self.window!.bounds.height * 1.444, height: self.window!.bounds.height)
        backgroundImg.contentMode = .scaleAspectFill
        backgroundImg.alpha = 0;
        //print("image alpha down ImageAlpha: \(backgroundImg.alpha)")
        UIView.animate(withDuration: 5, animations: {
            self.backgroundImg.alpha = 1;
            
        }) { (finished) in
            if finished {
                self.downAlphaForBackgroundImg()
            }
        }
        
        
        
        
    }
    
    func recursiveChangeBackgroundWithAnimation() {
        if (i == 5) {
            i = 0;
        }
        
        i = i + 1;
        
        backgroundImg.image = UIImage.init(named: "doctor-\(i)")
        backgroundImg.frame = CGRect(x: 0, y: 0, width: self.window!.bounds.height * 1.444, height: self.window!.bounds.height)
        backgroundImg.contentMode = .scaleAspectFill
        
        UIView.animate(withDuration: 5, animations: {
            if self.backgroundImg.alpha == 0 {
                self.backgroundImg.alpha = 1;
            } else if self.backgroundImg.alpha == 1 {
                self.backgroundImg.alpha = 0;
            }
            
            
        }) { (finished) in
            self.recursiveChangeBackgroundWithAnimation()
        }
        
        
        
        
        
    }
    
    func findTypes() {
        let url = URL(string: "http://localhost/hospital/userTypes.php")!;
        
        var request = URLRequest(url: url)
        print("Function Working")
        request.httpMethod = "GET";
        //let body = "";
        
       // request.httpBody = body.data(using: .utf8);
        print(request)
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? Array<NSDictionary>
                
                for doctorType in json! {
                    userType.append(doctorType["doctorType"] as! String)
                }
                
                print("Data parsed")
                
                
            } catch {
                print(error);
            }
        }.resume()
    }
    
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

