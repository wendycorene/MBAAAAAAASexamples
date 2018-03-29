//
//  ParseManagedObjects.swift
//  MBAAAAAAASexamples
//
//  Created by Eloe,Wendy C on 3/27/18.
//  Copyright © 2018 Eloe,Wendy C. All rights reserved.
//

import Foundation
import Parse

class Movie:PFObject, PFSubclassing {
    
    @NSManaged var title:String
    @NSManaged var year:Int
    @NSManaged var producer:String
    
    static func parseClassName() -> String {
        return "Movie"
    }
    
}

class Actor: PFObject, PFSubclassing {
    
    @NSManaged var name : String
    @NSManaged var starredIn: [Movie]
    
    static func parseClassName() -> String {
        return "Actor"
    }
}
