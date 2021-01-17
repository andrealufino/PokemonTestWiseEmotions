//
//  UIAlertControllerExtensions.swift
//  AMLExtensions
//
//  Created by Andrea Mario Lufino on 14/12/16.
//  Copyright © 2016 Andrea Mario Lufino. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit


public typealias ActionHandler = (_ action: UIAlertAction) -> ()
public typealias AttributedActionTitle = (title: String, style: UIAlertAction.Style)


// MARK: - UIAlertController - Present alert

public extension UIAlertController {
    
    /// Present an alert view on the top presented view controller
    ///
    /// - Parameters:
    ///   - style: The style of the alert
    ///   - title: The title
    ///   - message: The message
    ///   - actionTitles: The action titles
    ///   - handler: The block which handles the actions
    /// - Returns: A UIAlertController instance
    class func present(
        style: UIAlertController.Style = .alert,
        title: String?,
        message: String?,
        actionTitles: [String]?,
        handler: ActionHandler? = nil) -> UIAlertController {
        
        // Force unwrap rootViewController
        let rootViewController = UIApplication.shared.delegate!.window!!.rootViewController!
        
        return self.presentFromViewController(
            viewController: rootViewController,
            style: style,
            title: title,
            message: message,
            actionTitles: actionTitles,
            handler: handler
        )
    }
    
    /// Present an alert view on the top presented view controller
    ///
    /// - Parameters:
    ///   - style: The style of the alert
    ///   - title: The title
    ///   - message: The message
    ///   - attributedActionTitles: The action titles
    ///   - handler: The block which handles the actions
    /// - Returns: A UIAlertController instance
    class func present(
        style: UIAlertController.Style = .alert,
        title: String?,
        message: String?,
        attributedActionTitles: [AttributedActionTitle]?,
        handler: ActionHandler? = nil) -> UIAlertController {
        
        // Force unwrap rootViewController
        let rootViewController = UIApplication.shared.delegate!.window!!.rootViewController!
        
        return self.presentFromViewController(
            viewController: rootViewController,
            style: style,
            title: title,
            message: message,
            attributedActionTitles: attributedActionTitles,
            handler: handler
        )
    }
    
    /// Present an alert view on the top presented view controller
    ///
    /// - Parameters:
    ///   - viewController: The view controller to present the alert from
    ///   - style: The style of the alert
    ///   - title: The title
    ///   - message: The message
    ///   - actionTitles: The action titles
    ///   - handler: The block which handles the actions
    /// - Returns: A UIAlertController instance
    class func presentFromViewController(
        viewController: UIViewController,
        style: UIAlertController.Style = .alert,
        title: String?,
        message: String?,
        actionTitles: [String]?,
        handler: ActionHandler? = nil) -> UIAlertController {
        
        return self.presentFromViewController(
            viewController: viewController,
            style: style,
            title: title,
            message: message,
            attributedActionTitles: actionTitles?.map({ (title) -> AttributedActionTitle in
                return (title: title, style: .default)
            }), handler: handler)
    }
    
    /// Present an alert view on the top presented view controller
    ///
    /// - Parameters:
    ///   - viewController: The view controller to present the alert from
    ///   - style: The style of the alert
    ///   - title: The title
    ///   - message: The message
    ///   - attributedActionTitles: The action titles
    ///   - handler: The block which handles the actions
    /// - Returns: A UIAlertController instance
    class func presentFromViewController(
        viewController: UIViewController,
        style: UIAlertController.Style = .alert,
        title: String?,
        message: String?,
        attributedActionTitles: [AttributedActionTitle]?,
        handler: ActionHandler? = nil) -> UIAlertController {
        
        // Create an instance of UIALertViewController
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        // Loop all attributedActionTitles, create an UIAlertAction for each
        // attributedButtonTitles is array of tuple AttributedActionTitle
        if let _attributedActionTitles = attributedActionTitles {
            for _attributedActionTitle in _attributedActionTitles {
                let buttonAction = UIAlertAction(title: _attributedActionTitle.title, style: _attributedActionTitle.style, handler: { (action) -> Void in
                    handler?(action)
                })
                alertController.addAction(buttonAction)
            }
        }
        
        // It's fixed for case viewController is not presented viewcontroller
        viewController.topMostViewController?.present(alertController, animated: true) {}
        
        return alertController
    }
}


// MARK: UIViewController methods

public extension UIViewController {
    
    /// Present an alert view on the top presented view controller
    ///
    /// - Parameters:
    ///   - style: The style of the alert
    ///   - title: The title
    ///   - message: The message
    ///   - actionTitles: The action titles
    ///   - handler: The block which handles the actions
    /// - Returns: A UIAlertController instance
    func presentAlert(
        style: UIAlertController.Style = .alert,
        title: String?,
        message: String?,
        actionTitles: [String]?,
        handler: ActionHandler? = nil) -> UIAlertController {
        
        return UIAlertController.presentFromViewController(
            viewController: self,
            style: style,
            title: title,
            message: message,
            actionTitles: actionTitles,
            handler: handler
        )
    }
    
    /// Present an alert view on the top presented view controller
    ///
    /// - Parameters:
    ///   - viewController: The view controller to present the alert from
    ///   - style: The style of the alert
    ///   - title: The title
    ///   - message: The message
    ///   - actionTitles: The action titles
    ///   - handler: The block which handles the actions
    /// - Returns: A UIAlertController instance
    func presentAlert(
        style: UIAlertController.Style = .alert,
        title: String?,
        message: String?,
        attributedActionTitles: [AttributedActionTitle]?,
        handler: ActionHandler? = nil) -> UIAlertController {
        
        return UIAlertController.presentFromViewController(
            viewController: self,
            style: style,
            title: title,
            message: message,
            attributedActionTitles: attributedActionTitles,
            handler: handler
        )
    }
    
    /// The view controller on top present level
    internal var topPresentedViewController: UIViewController? {
        get {
            var target: UIViewController? = self
            while (target?.presentedViewController != nil) {
                target = target?.presentedViewController
            }
            return target
        }
    }
    
    /// Get top VisibleViewController from ViewController stack in same present level.
    ///
    /// **Note**: It should be topViewController if self is a UINavigationController instance.
    /// It should be selectedViewController if self is a UITabBarContrller instance.
    internal var topVisibleViewController: UIViewController? {
        get {
            if let nav = self as? UINavigationController {
                return nav.topViewController?.topVisibleViewController
            }
            else if let tabBar = self as? UITabBarController {
                return tabBar.selectedViewController?.topVisibleViewController
            }
            return self
        }
    }
    
    /// Combine both topPresentedViewController and topVisibleViewController methods, to get top visible viewcontroller in top present level
    internal var topMostViewController: UIViewController? {
        get {
            return self.topPresentedViewController?.topVisibleViewController
        }
    }
}


#endif
