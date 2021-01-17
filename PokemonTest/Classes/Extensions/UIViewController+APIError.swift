//
//  UIViewController+APIError.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 17/01/21.
//

import Foundation
import UIKit


extension UIViewController {
    
    func showAlert(withAPIError apiError: APIError, title: String = "Error") {
        
        guard !apiError.userMessage.isEmpty else {
            fatalError("You should not display an APIError without a user message.")
        }
        
        _ = presentAlert(title: title, message: apiError.userMessage, actionTitles: ["Ok"])
    }
}
