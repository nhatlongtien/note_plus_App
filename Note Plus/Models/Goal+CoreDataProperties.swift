//
//  Goal+CoreDataProperties.swift
//  Note Plus
//
//  Created by NGUYENLONGTIEN on 7/5/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//
//

import Foundation
import CoreData


extension Goal {
    static let instance = Goal()
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var goalCompletionValue: Int32
    @NSManaged public var goalDescription: String?
    @NSManaged public var goalProgress: Int32
    @NSManaged public var goalType: String?
    
    //Insert new Goal
    func insertNewGoal(goalDescription:String, goalType:String, goalCompletionValue:Int32, completion: @escaping (_ finish:Bool) -> Void){
        let newGoal = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: AppDelegate.managedObjectContext!) as! Goal
        newGoal.goalDescription = goalDescription
        newGoal.goalType = goalType
        newGoal.goalCompletionValue = goalCompletionValue
        newGoal.goalProgress = Int32(0)
        do{
            try AppDelegate.managedObjectContext?.save()
            completion(true)
            print("Insert new goal sucessfully")
        }catch let error as NSError{
            print("Can not insert new goal: \(error), description: \(error.description)")
            completion(false)
        }
    }
    //Fetch all goal from coreData
    func getAllGoal(completion: @escaping (_ goals:[Goal]) -> Void){
        var results = [Goal]()
        let managedObjectContext = AppDelegate.managedObjectContext
        do{
            results = try managedObjectContext?.fetch(Goal.fetchRequest()) as! [Goal]
            print("fetch all goal from coreData successfully")
            completion(results)
        }catch let error as NSError{
            print("Can't fetch goal: error: \(error), description: \(error.userInfo)")
        }
    }
    //Delete selected object
    func deleteObject(object: Goal, completion: @escaping (_ result:Bool) -> Void){
        let managedOnjectContext = AppDelegate.managedObjectContext
        managedOnjectContext?.delete(object)
        do{
            try managedOnjectContext?.save()
            completion(true)
        }catch let error as NSError{
            print("Can't delete this object. Error is: \(error)")
            completion(false)
        }
    }
    
    
    
    
    
}
