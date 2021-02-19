//
//  ResponseModal.swift
//  MovieList
//
//  Created by Berkehan on 19.02.2021.
//

import Foundation

struct ResponseModal<T: Codable>: Codable {
    
    // MARK: - Properties
        var isSuccess: Bool
        var message: String
        var error: ErrorModal {
            return ErrorModal(message)
        }
        var rawData: Data?
        var data: T?
        var json: String? {
            guard let rawData = rawData else { return nil }
            return String(data: rawData, encoding: String.Encoding.utf8)
        }
        
        public init(from decoder: Decoder) throws {
            let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
            
            isSuccess = (try? keyedContainer.decode(Bool.self, forKey: CodingKeys.isSuccess)) ?? false
            message = (try? keyedContainer.decode(String.self, forKey: CodingKeys.message)) ?? ""
            data = try? keyedContainer.decode(T.self, forKey: CodingKeys.data)
        }
    }

    // MARK: - Private Functions
    extension ResponseModal {

        private enum CodingKeys: String, CodingKey {
            case isSuccess
            case message
            case data
        }
    }
