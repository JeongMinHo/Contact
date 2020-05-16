//
//  ContactViewController.swift
//  Closure
//
//  Created by jeongminho on 2020/05/14.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import UIKit

protocol ContactCellDelegate: class {
    func delete(contact: Contact)
    func reloadData()
}

class ContactViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    
    // MARK: - IBAction
    @IBAction func editButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            startEditing()
        } else {
            endEditing()
        }
        tableView.reloadData()
    }
    
    // MARK: - Property
    let model = ContactModel()

    // MARK: - Method
    func setup() {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
        
    //    @objc
    //    func deleteButtonDidTapped() {
    //        print(#function)
    //    }
        
    func startEditing() {
        editButton.setTitle("Complete", for: .normal)
    }
        
    func endEditing() {
        editButton.setTitle("Edit", for: .normal)
    }
    
//    func setUserDefaults() {
//        for i in 0...model.contacts.count-1 {
//            userDefaults.set(model.contacts[i].phoneNumber, forKey: model.contacts[i].phoneNumber)
//        }
////        print(userDefaults.value(forKey: model.contacts[4].phoneNumber) ?? 0)
//    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
//        self.setUserDefaults()
    }
}

extension ContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension ContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeued = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        guard let cell = dequeued as? ContactCell else {
            return dequeued
        }
        cell.contact = model.contacts[indexPath.row]
        cell.isEditButtonClicked = editButton.isSelected
        cell.delegate = self
//        cell.deleteAndReloadData = { [weak self] in
//            self?.tableView.reloadData()
//        }
        return cell
    }
}

extension ContactViewController: ContactCellDelegate {
    func delete(contact: Contact) {
        self.model.delete(contact: contact)
//        self.userDefaults.removeObject(forKey: contact.phoneNumber)
//        print(userDefaults.value(forKey: model.contacts[0].phoneNumber) ?? 0)
    
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    weak var delegate: ContactCellDelegate?
    // var deleteAndReloadData: (() -> Void)?
    
    var contact: Contact? {
        didSet {
            self.nameLabel.text = contact?.name
            self.phoneNumberLabel.text = contact?.phoneNumber
        }
    }
    
    var isEditButtonClicked: Bool = false {
        didSet {
            removeButton.isHidden = !isEditButtonClicked
        }
    }
    
    @IBAction func deleteButtonDidTapped(_ sender: UIButton) {
        guard let contact = contact else {
            return
        }
        delegate?.delete(contact: contact)
        delegate?.reloadData()
        // deleteAndReloadData?()
        // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DeleteButtonTapped"), object: nil)
    }
}
