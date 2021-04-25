//
//  Connectivity.swift
//  omdb
//
//  Created by Emin Tolgahan Polat on 23.04.2021.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
