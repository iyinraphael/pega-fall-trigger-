//
//  FallModelController.swift
//  PegaFallTrigger
//
//  Created by Iyin Raphael on 9/16/20.
//  Copyright © 2020 Iyin Raphael. All rights reserved.
//

import Foundation

enum NetWorkError: Error {
    case noIdentifier
    case otherError
    case noData
    case failedDecode
    case failedEncode
}

class FallModelController {
    
    // MARK: - Property
    
    let url = URL(string: "http://52.179.114.126/prweb/PRRestService/claims/v1/claim")!
    typealias completionHandler = (Result<Bool, NetWorkError>) -> Void
    
    // MARK: - Post Request Method
    
    func sendFallDataToPega(fallData: FallData, completion: @escaping completionHandler = { _ in } ){
        
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "POST"
        
        do {
            requestURL.httpBody = try JSONEncoder().encode(fallData)
        } catch {
            NSLog("Error sending faithDailyRep to server \(fallData): \(error)")
            completion(.failure(.failedEncode))
            return
        }
        URLSession.shared.dataTask(with: requestURL) { data, _, error in
            if let error = error {
                NSLog("Error sending data server: \(error)")
                completion(.failure(.otherError))
                return
            }
            completion(.success(true))
        }.resume()
    }
}
