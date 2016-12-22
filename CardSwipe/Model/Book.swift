//
//  Book.swift
//  CardSwipe
//
//  Created by Techjini on 28/11/16.
//  Copyright © 2016 Techjini. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Mappable {
    static func mapdata(data: Data?) -> [Book]?
}

struct Book {
    let title: String
    let subtitle: String
    let decription: String
    let authors: [String]?
    let thumbnail: URL
}

extension Book: Mappable {
    static func mapdata(data: Data?) -> [Book]? {
        let json = JSON(data: data!,
                        options: .allowFragments,
                        error: nil)
        var books = [Book]()
        _ = json["items"].array?.map({
            let title =  $0["volumeInfo"]["title"].stringValue
            let subTitle  = $0["volumeInfo"]["subtitle"].stringValue
            let description = $0["volumeInfo"]["description"].stringValue
            let authors = $0["volumeInfo"]["authors"].arrayObject
            let thumbnail =  $0["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
            let book = Book(title: title,
                            subtitle: subTitle,
                            decription: description,
                            authors: authors as? [String],
                            thumbnail: URL(string: thumbnail)!)
            books.append(book)
        } )
        return books
    }

    
}
