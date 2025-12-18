//
//  UserProfileVC.swift
//  RelationsInCOreData
//
//  Created by Rajni on 18/12/25.
//

import UIKit
import CoreData


class UserProfileVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
        title = "One to One"
    }
    



        @IBAction func saveTapped(_ sender: UIButton) {
            if sender.tag == 1 {
                self.navigationController?.popViewController(animated: true)
            }else{
                guard
                    let name = nameTextField.text, !name.isEmpty,
                    let email = emailTextField.text, !email.isEmpty,
                    let phone = phoneTextField.text, !phone.isEmpty
                else {
                    resultLabel.text = "Please fill all fields"
                    return
                }

                createUserWithProfile(name: name, email: email, phone: phone)
            }
            
        }
    
    func createUserWithProfile(name: String, email: String, phone: String) {

        let context = CoreDataManager.shared.context

        let user = User(context: context)
        user.name = name

        let profile = Profile(context: context)
        profile.email = email
        profile.phone = phone

        // ⭐ ONE-TO-ONE RELATION
        user.profile = profile
        profile.user = user

        CoreDataManager.shared.saveContext()

        resultLabel.text = """
        Saved Successfully:
        User: \(name)
        Email: \(email)
        Phone: \(phone)
        """
        print("Saved Successfully: User: \(name) Email: \(email) Phone: \(phone)")
    }
    
    
    func fetchUsers() {
        let request: NSFetchRequest<User> = User.fetchRequest()
        let users = try? CoreDataManager.shared.context.fetch(request)

        if let user = users?.first {
            nameTextField.text = user.name ?? ""
            emailTextField.text = user.profile?.email ?? ""
            phoneTextField.text = user.profile?.phone ?? ""
            print(user.name ?? "")
            print(user.profile?.email ?? "")
        }
    }

    

}
