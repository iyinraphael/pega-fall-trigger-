//
//  FallData.swift
//  PegaFallTrigger
//
//  Created by Iyin Raphael on 9/14/20.
//  Copyright © 2020 Iyin Raphael. All rights reserved.
//

import Foundation

struct FallData: Codable {
    let deviceModel: String
    let deviceOwner: String
    let ownersEmail: String
    let latitude: Double?
    let longitude: Double?
    var indoor: Bool?
}
