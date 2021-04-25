//
//  ImageView+Extention.swift
//  omdb
//
//  Created by Emin Tolgahan Polat on 24.04.2021.
//

import Foundation
import UIKit


let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{
 
    func loadImage(_ path:String?,placeholder: UIImage? = nil){
        
        self.image = placeholder
        if let imageFromCache = imageCache.object(forKey: path as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        guard let url = URL(string: (path ?? "").contains("http") ? path! : "") else {
            self.image = UIImage(color: .darkGray)
            self.contentMode = .scaleAspectFill
            return }
        
        ApiClient.instance.request(url,method: .get).response{
            response in
            switch response.result {
            case .success(let responseData):
                let mImage = UIImage(data: responseData!, scale:1)
                DispatchQueue.main.async() { () -> Void in
                    imageCache.setObject(mImage!, forKey: path as AnyObject)
                    self.image = mImage
                }
            case .failure(_):
                self.image = UIImage(color: .blue)
                self.contentMode = .scaleAspectFit
            }
            
            
        }
        
    }
}


extension UIImage {
    fileprivate convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
