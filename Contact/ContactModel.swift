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
        if UserDefaults.standard.object(forKey: "Contact") == nil {
            getContacts()
            encodedContact()
        } else {
            getContactUserDefaults()
        }
    }
    
    func delete(contact: Contact) {
        contacts.removeAll { $0 == contact }
        encodedContact()
    }
    
    private func getContacts() {
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        do {
            try contactStore.enumerateContacts(with: CNContactFetchRequest(keysToFetch: keysToFetch)) { cnContact, pointer in
                self.contacts.append(Contact(name: cnContact.givenName + cnContact.familyName, phoneNumber: cnContact.phoneNumbers.first?.value.stringValue ?? ""))
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func encodedContact() {
        let jsonEncoder: JSONEncoder = JSONEncoder()
        do {
            let encoded = try jsonEncoder.encode(contacts)
            UserDefaults.standard.set(encoded, forKey: "Contact")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getContactUserDefaults() {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let data = UserDefaults.standard.data(forKey: "Contact") else { return }
        
        do {
            let decoded = try jsonDecoder.decode([Contact].self, from: data)
            print(decoded)
            self.contacts = decoded
        } catch {
            print(error.localizedDescription)
        }
    }
}
