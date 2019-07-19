//
//  ViewController.swift
//  NSBatchUpdateRequest
//
//  Created by Trương Quang on 7/19/19.
//  Copyright © 2019 truongquang. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        print(appDelegate.persistentContainer.persistentStoreDescriptions)
        insert()
//        update()
        updateWithBatch()
    }
    
    func insert() {
        guard let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedObjectContext!) else { return }

        for i in 1...50000 {
            let student = NSManagedObject(entity: entity, insertInto: managedObjectContext)
            student.setValue("\(Data())", forKey: "studentName")
            student.setValue(Int64(i), forKey: "studentRollNo")
        }
        /*
        // You can do
        for i in 1...50000 {
            let student = NSEntityDescription.insertNewObject(forEntityName: "Student", into: managedObjectContext!)
            student.setValue("\(Data())", forKey: "studentName")
            student.setValue(Int64(i), forKey: "studentRollNo")
        }
         */
    }
    
    func currentTimeMillis() -> Int64 {
        return Int64(Date().timeIntervalSince1970*1000)
    }
    
    func update() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        do {
            let start = currentTimeMillis()
            let searchResults = try managedObjectContext?.fetch(request) as! [Student]
            for student in searchResults {
                student.studentName = "Quang"
            }
            
            appDelegate.saveContext()
            print("Difference is \(currentTimeMillis() - start)")
        } catch {
            print(error)
        }
    }
    
    func updateWithBatch() {
        let request = NSBatchUpdateRequest(entityName: "Student")
        request.propertiesToUpdate = ["studentName":"Truong"]
        request.resultType = .updatedObjectsCountResultType
        
        do {
            let start = currentTimeMillis()
            let result = try managedObjectContext?.execute(request) as! NSBatchUpdateResult
            print(result.resultType)
            print("Success")
            print("Difference is \(currentTimeMillis() - start)")
        } catch {
            
        }
    }

}













