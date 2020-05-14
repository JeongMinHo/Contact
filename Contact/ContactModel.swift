//
//  ContactModel.swift
//  Contact
//
//  Created by jeongminho on 2020/05/14.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation
import Contacts

// 데이터를 관리
class ContactModel {
    
    private let contactStore = CNContactStore()
    
    private(set) var contacts = [Contact]()
    
    init() {
        getContacts()
    }
    
    func delete(contact: Contact) {
        contacts.removeAll { $0 == contact }
    }
    
    private func getContacts() {
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        do {
            try contactStore.enumerateContacts(with: CNContactFetchRequest(keysToFetch: keysToFetch)) { cnContact, pointer in
                self.contacts.append(Contact(name: cnContact.givenName + cnContact.familyName, phoneNumber: cnContact.phoneNumbers.first?.value.stringValue ?? ""))
            }
        } catch {
        }
    }
}
