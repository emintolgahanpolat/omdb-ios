//
//  ViewController+Extention.swift
//  omdb
//
//  Created by Emin Tolgahan Polat on 25.04.2021.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlert(title:String?,message:String?,actions:[UIAlertAction]?){
        let alert =  UIAlertController( title: title, message: message, preferredStyle: .alert)
        
        if (actions != nil){
            for item in actions! {
                alert.addAction(item)
            }
        }else{
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}



extension UIApplication{
    static var getKeyWindow: UIWindow {
        get{
            let window = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            
            return window!
        }
    }
    
}
class ETPViewController: UIViewController{
    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
    }
}
