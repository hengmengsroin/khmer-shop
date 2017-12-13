//
//  Restaurant.swift
//  Khmer Shops
//
//  Created by Mengsroin Heng on 12/11/17.
//  Copyright © 2017 Mengsroin Heng. All rights reserved.
//

import Foundation
class Restaurant {
    var name: String
    var description: String
    var latitude: Double
    var longtitude: Double
    var logoThumbnail: String
    var openTime: String
    
    init(name: String, description: String, logoThumbnail: String) {
        self.name = name
        self.description = description
        self.logoThumbnail = logoThumbnail
        self.latitude = 0
        self.longtitude = 0
        self.openTime = ""
    }
    
}
