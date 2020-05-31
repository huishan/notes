//
//  NoteStore.swift
//  Note
//
//  Created by huishan on 2020/5/30.
//  Copyright © 2020 huishan. All rights reserved.
//

import Foundation

class NoteStore {
    var notes = [Note]()
    
    func addNote(note: Note){
        notes.insert(note, at: 0)
    }
    
    func removeNote(position: Int){
        notes.remove(at: position)
    }
    
    func editNote(position: Int, note: Note){
        notes[position] = note
    }
}
