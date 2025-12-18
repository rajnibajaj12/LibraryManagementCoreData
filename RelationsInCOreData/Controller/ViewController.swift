//
//  ViewController.swift
//  RelationsInCOreData
//
//  Created by Rajni on 18/12/25.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    let context = UIApplication.context

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Core Data Relations"
    }
    @IBAction func actionButtontapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            navigate(to: .oneToMany)
        case 2:
            navigate(to: .manyToMany)
        case 3:
            navigate(to: .oneToOne)
        default:
            break
        }
    }
    
    func navigate(to type: RelationType) {
        switch type {
        case .oneToMany:
            let vc = storyboard?.instantiateViewController(
                withIdentifier: "AuthorListVC"
            ) as! AuthorListVC
            navigationController?.pushViewController(vc, animated: true)

        case .manyToMany:
            let vc = storyboard?.instantiateViewController(
                withIdentifier: "ManyToManyrelationVC"
            ) as! ManyToManyrelationVC
            navigationController?.pushViewController(vc, animated: true)

        case .oneToOne:
            let vc = storyboard?.instantiateViewController(
                withIdentifier: "UserProfileVC"
            ) as! UserProfileVC
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}


