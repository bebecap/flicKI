//
//  PhotoResponse.swift
//  flicKI
//
//  Created by Volodymyr Grytsenko on 10.02.2018.
//  Copyright © 2018 Volodymyr Grytsenko. All rights reserved.
//

import Foundation
import ObjectMapper

final class PhotoResponse: Mappable {
    
    var items: [Photo]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        items <- map["items"]
    }
}
