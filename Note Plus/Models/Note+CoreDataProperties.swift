//
//  Note+CoreDataProperties.swift
//  Note Plus
//
//  Created by NGUYENLONGTIEN on 7/9/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {
    static var instance = Note()
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var content: String?
    @NSManaged public var lockStatus: Bool
    @NSManaged public var createDate: Date?
    
    //Create new Note
    func insertNewNote(noteContent:String, lockStatus:Bool, completion: @escaping (_ result:Bool) -> Void){
        let newNote = NSEntityDescription.insertNewObject(forEntityName: "Note", into: AppDelegate.managedObjectContext!) as! Note
        newNote.content = noteContent
        newNote.createDate = Date()
        newNote.lockStatus = lockStatus
        do{
            try AppDelegate.managedObjectContext?.save()
            completion(true)
        }catch let error as NSError{
            print("Can not create new Note. Error is: \(error)")
            completion(false)
        }
    }
    //Get All note from Note coreData
    func getAllNote(completion: @escaping (_ notes:[Note]) -> Void){
        var results = [Note]()
        let request:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do{
            results = try AppDelegate.managedObjectContext?.fetch(request) as! [Note]
            completion(results)
        }catch let error as NSError{
            print("Can not get all note from coreData. Error is: \(error)")
        }
    }
}
