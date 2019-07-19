//
//  Student+CoreDataProperties.swift
//  NSBatchUpdateRequest
//
//  Created by Trương Quang on 7/19/19.
//  Copyright © 2019 truongquang. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var studentName: String?
    @NSManaged public var studentRollNo: Int64

}
