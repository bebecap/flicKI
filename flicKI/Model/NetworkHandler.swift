//
//  NetworkHandler.swift
//  flicKI
//
//  Created by Volodymyr Grytsenko on 10.02.2018.
//  Copyright © 2018 Volodymyr Grytsenko. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class NetworkHandler {
    
    static let flickrPhotoLink = "https://api.flickr.com/services/feeds/photos_public.gne"
    
    static func getPublicFeedPhoto(filters: String, completion: @escaping ([Photo])->(), error: @escaping (Error)->()) {
        Alamofire.request(NetworkHandler.flickrPhotoLink, parameters: ["nojsoncallback": "1", "format": "json", "tags": filters]).responseObject { (response: DataResponse<PhotoResponse>) in
                
                switch(response.result) {
                case .success(_):
                    if let photos = response.result.value?.items {
                        completion(photos)
                    }
                    break
                    
                case .failure(_):
                    error(response.result.error!)
                    break
                }
        }
    }
    
}
