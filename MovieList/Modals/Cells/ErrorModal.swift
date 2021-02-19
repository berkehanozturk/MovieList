//
//  ErrorModal.swift
//  MovieList
//
//  Created by Berkehan on 19.02.2021.
//

import Foundation
class ErrorModal: Error {
    
    // MARK: - Properties
    var messageKey: String
    var message: String {
        return messageKey
    }
    
    init(_ messageKey: String) {
        self.messageKey = messageKey
    }
}

// MARK: - Public Functions
extension ErrorModal {
    
    class func generalError() -> ErrorModal {
        return ErrorModal("Error")
    }
}
