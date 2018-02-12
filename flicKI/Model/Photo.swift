//
//  Photo.swift
//  flicKI
//
//  Created by Volodymyr Grytsenko on 10.02.2018.
//  Copyright © 2018 Volodymyr Grytsenko. All rights reserved.
//

import Foundation
import ObjectMapper

final class Photo: Mappable, CustomStringConvertible {
    
    var author_id: String?
    var title: String?
    var link: URL?
    var takenDate: Date?
    var imagePreviewLink: URL?
    var imageLink: URL?
    var tags: String?

    required convenience public init?(map: Map) {
        self.init()
    }
    
    public var description: String { return "Photo: \n\tAuthor: \(author_id ?? "") \n\tTitle: \(title ?? "") \n\tDate: \(takenDate ?? Date()) \n\tLink: \(link ?? URL(string: "http://flickr.com")!) \n\tImage link: \(imagePreviewLink ?? URL(string: "http://flickr.com")!) \n\tTags:\(tags ?? "") \n" }
    
    // MARK: - ObjectMapper protocol methods
    public func mapping(map: Map) {
        self.author_id <- map["author_id"]
        self.title <- map["title"]
        self.link <- (map["link"], URLTransform())
        self.takenDate <- (map["date_taken"], FlickrDateTransform())
        self.imagePreviewLink <- (map["media.m"], URLTransform())
        self.tags <- map["tags"]
        self.imageLink <- (map["media.m"], FlickrBigImageTransform())
    }
}

class FlickrDateTransform: TransformType
{
    func transformFromJSON(_ value: Any?) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from:value as! String)!
    }
    
    func transformToJSON(_ value: Date?) -> String? {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.string(from: value!)
    }
    
    typealias Object = Date
    
    typealias JSON = String

}

class FlickrBigImageTransform: TransformType
{
    typealias Object = URL
    
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> URL? {
        guard let link = value as? String else {
            return nil
        }
        return URL(string: link.replacingOccurrences(of: "_m.", with: "_b."))
    }
    
    func transformToJSON(_ value: URL?) -> String? {
       return value?.absoluteString
    }
    
}
