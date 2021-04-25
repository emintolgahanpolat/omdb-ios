//
//  SplashViewModel.swift
//  omdb
//
//  Created by Emin Tolgahan Polat on 24.04.2021.
//

import Foundation
import Firebase

struct AppSettings {
    let name,color:String
}
class SplashViewModel {
    
    var appSettings:Observable<AppSettings> = Observable(nil)
    
    
    
    func getRemoteConfig(){
        
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.fetchAndActivate { (status, error) in
            if status != .error{
                self.appSettings.value = AppSettings(name: remoteConfig["app_name"].stringValue ?? "", color: remoteConfig["app_color"].stringValue ?? "#ffffffff")
            }
        }
    }
}
