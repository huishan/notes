//
//  FormController.swift
//  Note
//
//  Created by huishan on 2020/5/31.
//  Copyright © 2020 huishan. All rights reserved.
//

import UIKit

class FormController: UIViewController {
    
    var editNote: Note?
    var delegate: NoteDelegate?
    
    @IBOutlet weak var headerTitle: UINavigationItem!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextView!
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBAction func submitForm(_ sender: Any) {
        
        let title = titleField.text ?? "New Note"
        let content = contentField.text ?? ""
        let note = Note(title: title, content: content)
        if (editNote != nil){
            delegate?.editNote(note: note)
        } else {
            delegate?.addNote(note: note)
        }
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (editNote != nil){
            titleField.text = editNote?.title
            contentField.text = editNote?.content
            submitBtn.setTitle("Edit", for: .normal)
            headerTitle.title = "Edit Note"
        }
    }
}
