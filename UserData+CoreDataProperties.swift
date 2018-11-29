//
//  UserData+CoreDataProperties.swift
//  ScottPro
//
//  Created by 李書賢 on 2018/10/18.
//  Copyright © 2018年 Awei. All rights reserved.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var cheep01: Int32
    @NSManaged public var cheep02: Int32
    @NSManaged public var cheep03: Int32
    @NSManaged public var email: String?
    @NSManaged public var mobile: String?
    @NSManaged public var password: String?
    @NSManaged public var star: Int32
    @NSManaged public var time1_3days: String?
    @NSManaged public var time2_3days: String?
    @NSManaged public var time3_3days: String?
    @NSManaged public var username: String?

}
