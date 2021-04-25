//
//  SplashViewController.swift
//  omdb
//
//  Created by Emin Tolgahan Polat on 24.04.2021.
//

import UIKit

class SplashViewController: UIViewController {
    
    lazy var appNameLabel: UILabel = {
        let mLabel = UILabel()
        mLabel.textAlignment = .center
        mLabel.numberOfLines = 0
        mLabel.font = .systemFont(ofSize: 30, weight: .bold)
        mLabel.translatesAutoresizingMaskIntoConstraints = false
        return mLabel
    }()
    
    lazy var viewModel: SplashViewModel = {
        return SplashViewModel()
    }()
    
    private func setupUI(){
        view.addSubview(appNameLabel)
        appNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16).isActive = true
        appNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -16).isActive = true
        appNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        if(Connectivity.isConnectedToInternet()){
            viewModel.getRemoteConfig()
        }else{
            self.appNameLabel.text = "İnternet bağlantısı bulunamadı..."
            self.view.backgroundColor = .red
        }
        
        viewModel.appSettings.bind{
            i in
            if let appSetting = i.value{
                UIView.animate(withDuration: 0.3, animations: {
                    self.appNameLabel.text = appSetting.name
                    self.view.backgroundColor = UIColor(hex: appSetting.color)
                    
                })
                
            }
            self.goHome()
        }
        
    }
    
    func goHome()  {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            let vc = HomeViewController()
            let nc = UINavigationController(rootViewController: vc)
            nc.navigationBar.isTranslucent = false
            UIApplication.getKeyWindow.rootViewController = nc
            UIApplication.getKeyWindow.makeKeyAndVisible()
        }
    }
    
    
}
