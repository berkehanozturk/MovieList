//
//  ErrorModal.swift
//  MovieList
//
//  Created by Berkehan on 17.02.2021.
//

import Foundation
class ErrorModal: Error {
    
    // MARK: - Properties
    var messageKey: String
    var message: String {
        return messageKey.localizedLowercase
    }
    
    init(_ messageKey: String) {
        self.messageKey = messageKey
    }
}

// MARK: - Public Functions
extension ErrorModal {
    
    class func generalError() -> ErrorModal {
        return ErrorModal(ErrorKey.general.rawValue)
    }
}
enum ErrorKey: String {
    case general = "Error_general"
    case parsing = "Error_parsing"
}
