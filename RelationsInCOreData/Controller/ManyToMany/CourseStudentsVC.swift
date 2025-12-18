//
//  CourseStudentsVC.swift
//  RelationsInCOreData
//
//  Created by Rajni on 19/12/25.
//

import CoreData
import UIKit

class CourseStudentsVC: UIViewController, UITableViewDelegate,
    UITableViewDataSource
{

    @IBOutlet weak var tableView: UITableView!
    var course: Course!
    var students: [Student] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = course.title
        tableView.delegate = self
        tableView.dataSource = self
        fetchStudents()
    }
    @IBAction func actionBacktapped(_ sender: UIBarButtonItem) {

        self.navigationController?.popViewController(animated: true)

    }

    func fetchStudents() {
        students = (course.students?.allObjects as? [Student]) ?? []
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        students.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        )
        cell.textLabel?.text = students[indexPath.row].name
        return cell
    }

}
