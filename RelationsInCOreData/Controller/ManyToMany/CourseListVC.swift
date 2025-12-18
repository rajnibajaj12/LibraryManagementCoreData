//
//  CourseListVC.swift
//  RelationsInCOreData
//
//  Created by Rajni on 19/12/25.
//

import CoreData
import UIKit

class CourseListVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var tableView: UITableView!
    var courses: [Course] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Courses"
        tableView.delegate = self
        tableView.dataSource = self
        fetchCourses()
    }
    @IBAction func actionBacktapped(_ sender: UIBarButtonItem) {

        self.navigationController?.popViewController(animated: true)

    }

    func fetchCourses() {
        let request: NSFetchRequest<Course> = Course.fetchRequest()
        courses = (try? CoreDataManager.shared.context.fetch(request)) ?? []
        tableView.reloadData()
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
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let vc =
            storyboard?.instantiateViewController(
                withIdentifier: "CourseStudentsVC"
            ) as! CourseStudentsVC

        vc.course = courses[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}
