//
//  BaseViewController.swift
//  CinemoTask
//
//  Created by Vinculum on 6/5/2020.
//  Copyright © 2020 Anubhav. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
       
     
        
        func openViewControllerBasedOnIdentifier(_ strIdentifier:String){
            let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: strIdentifier)
            
            let _ : UIViewController = self.navigationController!.topViewController!
    //        self.navigationController!.navigationBar.tintColor = UIColor.white;
            self.navigationController!.pushViewController(destViewController, animated: true)
            
        }
        
        func addSlideMenuButtonVoucher(){
            
//            let btn1 = UIButton(type: .custom)
//            btn1.setImage(UIImage(named: "cardicon"), for: .normal)
//            btn1.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//            btn1.imageView?.contentMode = .scaleAspectFit
//            btn1.imageEdgeInsets = UIEdgeInsets(top: 45, left: 45, bottom: 45, right: 45)
//            btn1.addTarget(self, action: #selector(BaseViewController.openMembershipcard(_:)), for: .touchUpInside)
//            let item1 = UIBarButtonItem(customView: btn1)
//            
//            self.navigationItem.setRightBarButtonItems([item1], animated: true)
        }
    
        func defaultMenuImage() -> UIImage {
            var defaultMenuImage = UIImage()
            
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 22), false, 0.0)
            
            UIColor.black.setFill()
            UIBezierPath(rect: CGRect(x: 0, y: 3, width: 30, height: 1)).fill()
            UIBezierPath(rect: CGRect(x: 0, y: 10, width: 30, height: 1)).fill()
            UIBezierPath(rect: CGRect(x: 0, y: 17, width: 30, height: 1)).fill()
            
            UIColor.white.setFill()
            UIBezierPath(rect: CGRect(x: 0, y: 4, width: 30, height: 1)).fill()
            UIBezierPath(rect: CGRect(x: 0, y: 11,  width: 30, height: 1)).fill()
            UIBezierPath(rect: CGRect(x: 0, y: 18, width: 30, height: 1)).fill()
            
            defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!
            
            UIGraphicsEndImageContext()
            
            return defaultMenuImage;
        }
}
