	//
//  Note.swift
//  Note
//
//  Created by huishan on 2020/5/30.
//  Copyright © 2020 huishan. All rights reserved.
//

import Foundation

class Note: NSObject, NSCoding {
    var title : String?
    var content : String?
    
    private let titleKey = "title"
    private let contentKey = "content"
    
    init(title: String, content: String = "") {
        self.title = title
        self.content = content
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(title, forKey: titleKey)
        aCoder.encode(content, forKey: contentKey)
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: titleKey) as? String,
              let content = aDecoder.decodeObject(forKey: contentKey) as? String
            else {return}
        
        self.title = title
        self.content = content
    }
}
