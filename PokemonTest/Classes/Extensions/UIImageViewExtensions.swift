//
//  UIImageViewExtensions.swift
//  AMLExtensions
//
//  Created by Andrea Mario Lufino on 08/03/2018.
//

import Foundation
#if canImport(UIKit)
import UIKit


// MARK: - UIImageView - Blur

public extension UIImageView {
    
    /// Make image view blurry.
    ///
    /// - Parameter style: `UIBlurEffectStyle` (default is `.light`).
    func blur(withStyle style: UIBlurEffect.Style = .light) {
        
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        
        addSubview(blurEffectView)
        
        clipsToBounds = true
    }
    
    /// Blurred version of an image view.
    ///
    /// - Parameter style: `UIBlurEffectStyle` (default is `.light`).
    /// - Returns: Blurred version of self.
    func blurred(withStyle style: UIBlurEffect.Style = .light) -> UIImageView {
        
        let imgView = self
        
        imgView.blur(withStyle: style)
        
        return imgView
    }
}


// MARK: - UIImageView - Download

public extension UIImageView {
    
    /// Set image from url
    ///
    /// - Parameters:
    ///   - url: URL of image
    ///   - contentMode: imageView content mode (default is .scaleAspectFit)
    ///   - placeHolder: optional placeholder image
    ///   - completionHandler: optional completion handler to run when download finishs (default is nil)
    func download(
        from url: URL,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        placeholder: UIImage? = nil,
        completionHandler: ((UIImage?) -> Void)? = nil) {
        
        image = placeholder
        
        self.contentMode = contentMode
        
        URLSession.shared.dataTask(with: url) { (data, response, _) in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data,
                let image = UIImage(data: data)
                else {
                    
                    completionHandler?(nil)
                    
                    return
            }
            
            DispatchQueue.main.async {
                
                self.image = image
                
                completionHandler?(image)
            }
        }.resume()
    }
}


#endif