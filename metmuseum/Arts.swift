//
//  Arts.swift
//  metmuseum
//
//  Created by Kamila Sultanova on 10.08.2023.
//

import Foundation
import SwiftyJSON

struct Arts{
    var artistDisplayName = ""
    var primaryImage = ""
    var title = ""
    var objectDate = ""
    var medium = ""
    var objectURL = ""
    
    init(){
        
    }
    
    init(json: JSON){
        if let item = json["artistDisplayName"].string{
            artistDisplayName = item
        }
        if let item = json["primaryImage"].string{
            primaryImage = item
        }
        if let item = json["title"].string{
            title = item
        }
        if let item = json["objectDate"].string{
            objectDate = item
        }
        if let item = json["medium"].string{
            medium = item
        }
        if let item = json["objectURL"].string{
            objectURL = item
        }
    }
}
