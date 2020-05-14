//
//  Contact.swift
//  Contact
//
//  Created by jeongminho on 2020/05/14.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation

class Contact: Equatable {
    
    var name: String
    var phoneNumber: String
    
    init(name: String, phoneNumber: String) {
        self.name = name
        self.phoneNumber = phoneNumber
    }
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.phoneNumber == rhs.phoneNumber
    }
}
