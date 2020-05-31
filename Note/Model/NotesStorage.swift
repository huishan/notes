//
//  NoteStorage.swift
//  Note
//
//  Created by huishan on 2020/5/30.
//  Copyright © 2020 huishan. All rights reserved.
//

import Foundation

class NotesStorage {
    
    private static let KEY = "notes"
    
    private static func archive(notes:[Note]) -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: notes, requiringSecureCoding: false)
    }
    static func retrieve() -> [Note]? {
        guard let data = UserDefaults.standard.object(forKey: KEY) as? Data else {return nil}
        
        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Note] ?? []
    }
    
    static func save(notes:[Note]) {
        let archivedNotes = archive(notes: notes)
        
        UserDefaults.standard.set(archivedNotes, forKey: KEY)
        UserDefaults.standard.synchronize()
    }
    
}
