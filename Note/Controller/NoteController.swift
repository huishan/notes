//
//  NoteController.swift
//  Note
//
//  Created by huishan on 2020/5/30.
//  Copyright © 2020 huishan. All rights reserved.
//

import UIKit

class NoteController: UITableViewController, NoteDelegate {
    var editedIndexPath: IndexPath?
    var noteStore: NoteStore!{
        didSet {
            noteStore.notes = NotesStorage.retrieve() ?? []
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    func addNote(note: Note) {
        self.noteStore.addNote(note: note)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        NotesStorage.save(notes: self.noteStore.notes)
    }
    
    func editNote(note: Note) {
        self.noteStore.editNote(position: editedIndexPath!.row, note: note)
        tableView.reloadRows(at: [editedIndexPath!], with: .top)
        NotesStorage.save(notes: self.noteStore.notes)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return noteStore.notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        cell.textLabel?.text = noteStore.notes[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) {(action,sourceView, completionHandler) in
            
            self.noteStore.removeNote(position: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            NotesStorage.save(notes: self.noteStore.notes)
            
            completionHandler(true)
        }
        
        deleteAction.title = "Delete"
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.editedIndexPath = indexPath
         performSegue(withIdentifier: "form", sender: self)
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        self.editedIndexPath = nil
        performSegue(withIdentifier: "form", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let formController = segue.destination as? FormController
        formController?.delegate = self
        
        if (editedIndexPath != nil){
            formController?.editNote = self.noteStore.notes[editedIndexPath!.row]
        } else {
            formController?.editNote = nil
        }
    }
}

protocol NoteDelegate {
    func addNote(note : Note)
    func editNote(note: Note)
}
