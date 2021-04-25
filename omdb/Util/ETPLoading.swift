//
//  ETPLoading.swift
//  omdb
//
//  Created by Emin Tolgahan Polat on 24.04.2021.
//

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class ETPLoading {
    static let sharedInstance = ETPLoading()
    
    lazy var container: UIView = {
        let mContainer = UIView(frame: CGRect.zero)
        mContainer.translatesAutoresizingMaskIntoConstraints = false
        return mContainer
    }()
    
    lazy var subContainer: UIView = {
        let mContainer = UIView(frame: CGRect.zero)
        mContainer.backgroundColor = .white
        mContainer.layer.cornerRadius = 24
        mContainer.layer.masksToBounds = true
        mContainer.translatesAutoresizingMaskIntoConstraints = false
        return mContainer
    }()
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let mIndicatorView = UIActivityIndicatorView(frame: CGRect.zero)
        mIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return mIndicatorView
    }()
    
    
   
    
    init() {
        //Main Container
        container.backgroundColor = UIColor.clear
        
        
        //Activity Indicator
        indicatorView.hidesWhenStopped = true
        
    }
    
    func show() -> Void {
        
        container.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        indicatorView.style = UIActivityIndicatorView.Style.large
        indicatorView.color = UIColor.black
        
        indicatorView.startAnimating()
        
        container.addSubview(subContainer)
        subContainer.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.3).isActive = true
        subContainer.heightAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.3).isActive = true
        subContainer.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        subContainer.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        
        
        subContainer.addSubview(indicatorView)
        indicatorView.leftAnchor.constraint(equalTo: subContainer.leftAnchor).isActive = true
        indicatorView.rightAnchor.constraint(equalTo: subContainer.rightAnchor).isActive = true
        indicatorView.topAnchor.constraint(equalTo: subContainer.topAnchor).isActive = true
        indicatorView.bottomAnchor.constraint(equalTo: subContainer.bottomAnchor).isActive = true
        
        if let window = getKeyWindow() {
            window.addSubview(container)
            container.leftAnchor.constraint(equalTo: window.leftAnchor).isActive = true
            container.rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true
            container.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
            container.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
        }
        container.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: {
            self.container.alpha = 1.0
        })
    }
    
    
    
    func hide() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.container.alpha = 0.0
        }) { finished in
            self.indicatorView.stopAnimating()
            
            self.indicatorView.removeFromSuperview()
            
            self.subContainer.removeFromSuperview()
            
            self.container.removeFromSuperview()
        }
    }
    
    
    private func getKeyWindow() -> UIWindow? {
        let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        return window
    }
}
