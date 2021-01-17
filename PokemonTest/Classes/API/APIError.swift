//
//  APIError.swift
//
//  Created by Andrea Mario Lufino on 16/04/2020.
//  Copyright © 2020 Andrea Mario Lufino. All rights reserved.
//

import Foundation


class APIError: Error, CustomStringConvertible {
    
    // MARK: Vars
    
    private static let defaultUserMessage = "There were problems with the server. Try again later or contact an administrator."
    private static let defaultDebugMessage = ""
    private static let defaultInternalNote = ""
    private static let defaultAPIErrorMessage = ""
    
    var userMessage: String
    var debugMessage: String
    var apiErrorMessage: String?
    var internalNote: String?
    var httpStatusCode: Int?
    
    
    // MARK: Init
    
    public init() {
        
        self.userMessage = APIError.defaultUserMessage
        self.debugMessage = APIError.defaultDebugMessage
        self.internalNote = APIError.defaultInternalNote
        self.apiErrorMessage = APIError.defaultAPIErrorMessage
    }
    
    public init(
        withUserMessage userMessage: String = APIError.defaultUserMessage,
        debugMessage: String,
        internalNote: String = APIError.defaultInternalNote,
        apiErrorMessage: String = APIError.defaultAPIErrorMessage) {
        
        self.userMessage = userMessage
        self.debugMessage = debugMessage
        self.internalNote = internalNote
    }
    
    public static func error(
        withUserMessage userMessage: String = APIError.defaultUserMessage,
        debugMessage: String = APIError.defaultDebugMessage,
        internalNote: String = APIError.defaultInternalNote,
        apiErrorMessage: String = APIError.defaultAPIErrorMessage) -> APIError {
        
        return APIError.init(
            withUserMessage: userMessage,
            debugMessage: debugMessage,
            internalNote: internalNote
        )
    }
}


// MARK: - Methods

extension APIError {
    
    func attach(userMessage: String) -> APIError {
        
        self.userMessage = userMessage
        
        return self
    }
    
    func attach(debugMessage: String) -> APIError {
        
        self.debugMessage = debugMessage
        
        return self
    }
    
    func attach(internalNote: String) -> APIError {
        
        self.internalNote = internalNote
        
        return self
    }
    
    func attach(apiErrorMessage: String) -> APIError {
        
        self.apiErrorMessage = apiErrorMessage
        
        return self
    }
    
    func attach(httpStatusCode: Int) -> APIError {
        
        self.httpStatusCode = httpStatusCode
        
        return self
    }
}


// MARK: - Presets

extension APIError {
    
    // MARK: Presets
    
    public static var generic: APIError {
        return APIError.init()
    }
    
    public static var serverError: APIError {
        return APIError.init(
            withUserMessage: "There was an error on the server. Please, try again. If the error persist, contact an administrator.",
            debugMessage: "The status code of the request is different than 2xx."
        )
    }
    
    public static var logicError: APIError {
        return APIError.init(
            withUserMessage: "There was a problem communicating with the server.",
            debugMessage: "The status code is 2xx, but there was a logic error. Check your request and/or the logic on the backend."
        )
    }
    
    public static var noInternetConnection: APIError {
        return APIError.init(
            withUserMessage: "There's no internet connection. Try again later.",
            debugMessage: "No internet connection."
        )
    }
}
