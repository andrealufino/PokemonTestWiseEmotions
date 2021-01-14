//
//  UIViewExtensions.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 14/01/21.
//

import Foundation
import UIKit


/// Easy way to implement an activity indicator with blurred background
public extension UIView {
    
    fileprivate var blurLoaderViewTag: Int {
        return Int.max - 1
    }
    
    /// Show an `UIActivityLoader` on the current view with the specified effect.
    ///
    /// - Parameter effect: The effect of the blur.
    func showBlurredActivityIndicator(withBlurEffect effect: UIBlurEffect.Style) {
        
        let blurEffect = UIBlurEffect(style: effect)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.startAnimating()
        
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        
        blurEffectView.tag = blurLoaderViewTag
        
        self.addSubview(blurEffectView)
    }
    
    /// Hide the visible blurred activity indicator.
    func hideBlurredActivityIndicator() {
        
        if let blurLoaderView = viewWithTag(blurLoaderViewTag) {
            if blurLoaderView is UIVisualEffectView {
                blurLoaderView.removeFromSuperview()
            }
        }
    }
    
    /// Hide the visible blurred activity indicator after the passed number of seconds.
    ///
    /// - Parameter time: The number of seconds after the blurred activity indicator has to be hidden.
    func hideBlurredActivityIndicator(deadlineFromNow time: Double) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            self.hideBlurredActivityIndicator()
        }
    }
}
