//
//  StudentCourseVC.swift
//  RelationsInCOreData
//
//  Created by Rajni on 18/12/25.
//

import CoreData
import UIKit

class StudentCourseVC: UIViewController, UITableViewDelegate,
    UITableViewDataSource
{

    @IBOutlet weak var tableView: UITableView!
    var student: Student!
    var courses: [Course] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = student.name
        tableView.delegate = self
        tableView.dataSource = self
        fetchCourses()
    }

    @IBAction func actionBacktapped(_ sender: UIBarButtonItem) {
        if sender.tag == 1 {
            showAssignCourseAlert()
        } else {
            self.navigationController?.popViewController(animated: true)
        }

    }

    func fetchCourses() {
        courses = (student.courses?.allObjects as? [Course]) ?? []
        tableView.reloadData()
    }

    func fetchOrCreateCourse(title: String) -> Course {
        let context = CoreDataManager.shared.context

        let request: NSFetchRequest<Course> = Course.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        request.fetchLimit = 1

        if let existing = try? context.fetch(request).first {
            return existing
        }

        let newCourse = Course(context: context)
        newCourse.title = title
        return newCourse
    }
    func showAssignCourseAlert() {
        let alert = UIAlertController(
            title: "Assign Course",
            message: nil,
            preferredStyle: .alert
        )
        alert.addTextField { $0.placeholder = "Course title" }

        alert.addAction(
            UIAlertAction(title: "Assign", style: .default) { _ in
                let title = alert.textFields?.first?.text ?? ""
                guard !title.isEmpty else { return }

                let course = self.fetchOrCreateCourse(title: title)

                // Prevent duplicate assignment
                if !(self.student.courses?.contains(course) ?? false) {
                    self.student.addToCourses(course)
                    course.addToStudents(self.student)
                    CoreDataManager.shared.saveContext()
                }

                self.fetchCourses()
            }
        )

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        courses.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        )
        cell.textLabel?.text = courses[indexPath.row].title
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {

        if editingStyle == .delete {
            let course = courses[indexPath.row]

            // Remove relationship
            student.removeFromCourses(course)
            course.removeFromStudents(student)

            // Delete course if unused
            if course.students?.count == 0 {
                CoreDataManager.shared.context.delete(course)
            }

            CoreDataManager.shared.saveContext()
            fetchCourses()
        }
    }

}
