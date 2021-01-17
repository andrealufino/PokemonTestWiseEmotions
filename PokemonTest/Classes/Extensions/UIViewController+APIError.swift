//
//  UIViewController+APIError.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 17/01/21.
//

import Foundation
import UIKit


extension UIViewController {
    
    /// Show an alert with the user message of the error.
    /// - Parameters:
    ///   - apiError: The `APIError` instance.
    ///   - title: The title of the error. Default value is `Error`.
    func showAlert(withAPIError apiError: APIError, title: String = "Error") {
        
        guard !apiError.userMessage.isEmpty else {
            fatalError("You should not display an APIError without a user message.")
        }
        
        _ = presentAlert(title: title, message: apiError.userMessage, actionTitles: ["Ok"])
    }
}
