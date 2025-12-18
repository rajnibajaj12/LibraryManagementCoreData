//
//  StudentListVC.swift
//  RelationsInCOreData
//
//  Created by Rajni on 19/12/25.
//

import UIKit
import CoreData


class StudentListVC: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
        var students: [Student] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Students"
            tableView.delegate = self
            tableView.dataSource = self
            fetchStudents()
        }

        @IBAction func actionButtonTapped(_ sender: UIBarButtonItem) {
            if sender.tag == 1 {
                showAddStudentAlert()
            }else{
                self.navigationController?.popViewController(animated: true)
            }
          
        }

        func fetchStudents() {
            let request: NSFetchRequest<Student> = Student.fetchRequest()
            students = (try? CoreDataManager.shared.context.fetch(request)) ?? []
            tableView.reloadData()
        }

        func showAddStudentAlert() {
            let alert = UIAlertController(title: "New Student", message: nil, preferredStyle: .alert)
            alert.addTextField { $0.placeholder = "Student name" }

            alert.addAction(UIAlertAction(title: "Save", style: .default) { _ in
                let name = alert.textFields?.first?.text ?? ""
                if !name.isEmpty {
                    let student = Student(context: CoreDataManager.shared.context)
                    student.name = name
                    CoreDataManager.shared.saveContext()
                    self.fetchStudents()
                }
            })

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           students.count
       }

       func tableView(_ tableView: UITableView,
                      cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
           cell.textLabel?.text = students[indexPath.row].name
           cell.accessoryType = .disclosureIndicator
           return cell
       }

       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let vc = storyboard?.instantiateViewController(
               withIdentifier: "StudentCourseVC"
           ) as! StudentCourseVC

           vc.student = students[indexPath.row]
           navigationController?.pushViewController(vc, animated: true)
       }
}
