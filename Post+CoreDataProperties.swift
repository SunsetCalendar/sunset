//
//  Post+CoreDataProperties.swift
//  sunset
//
//  Created by usr0600429 on 2016/09/30.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post");
    }

    @NSManaged public var content: String?
    @NSManaged public var created_at: String?
    @NSManaged public var user_id: Int16

}
