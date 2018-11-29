//
//  Items+CoreDataProperties.swift
//  ScottPro
//
//  Created by 李書賢 on 2018/9/27.
//  Copyright © 2018年 Awei. All rights reserved.
//
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items")
    }

    @NSManaged public var shop: String?
    @NSManaged public var drink: String?
    @NSManaged public var money: String?
    @NSManaged public var time: String?
    @NSManaged public var many: String?

}
