//
//  ManyToManyrelationVC.swift
//  RelationsInCOreData
//
//  Created by Rajni on 19/12/25.
//

import CoreData
import UIKit

class ManyToManyrelationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Many to Many"

    }

    // MARK: - Actions

    @IBAction func actionButtonTapped(_ sender: UIButton) {
        if sender.tag == 1 {
            let vc =
                storyboard?.instantiateViewController(
                    withIdentifier: "StudentListVC"
                ) as! StudentListVC
            navigationController?.pushViewController(vc, animated: true)
        } else if sender.tag == 2 {
            let vc =
                storyboard?.instantiateViewController(
                    withIdentifier: "CourseListVC"
                ) as! CourseListVC
            navigationController?.pushViewController(vc, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }

    }

}
