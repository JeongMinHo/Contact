//
//  Contact.swift
//  Contact
//
//  Created by jeongminho on 2020/05/14.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation

class Contact: NSObject, NSCoding {
    
    var name: String
    var phoneNumber: String
    
    init(name: String, phoneNumber: String) {
        self.name = name
        self.phoneNumber = phoneNumber
    }
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.phoneNumber == rhs.phoneNumber
    }
    
    required init?(coder: NSCoder) {
        self.name = coder.decodeObject(forKey: "name") as? String ?? ""
        self.phoneNumber = coder.decodeObject(forKey: "phoneNumber") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.phoneNumber, forKey: "phoneNumber")
    }
}
