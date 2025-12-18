//
//  AuthorListVC.swift
//  RelationsInCOreData
//
//  Created by Rajni on 18/12/25.
//

import UIKit
import CoreData

class AuthorListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var authors: [Author] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchAuthors()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addAuthorTapped(_ sender: UIBarButtonItem) {
        if sender.tag == 1 {
            self.navigationController?.popViewController(animated: true )
        }else {
            showAddAuthorAlert()
        }
        
    }

        func fetchAuthors() {
            let request: NSFetchRequest<Author> = Author.fetchRequest()
            authors = (try? CoreDataManager.shared.context.fetch(request)) ?? []
            print("Authors Count : \(authors.count)")
            tableView.reloadData()
        }

        func createAuthor(name: String) {
            let author = Author(context: CoreDataManager.shared.context)
            author.name = name
            CoreDataManager.shared.saveContext()
            fetchAuthors()
        }
    
    
    func showAddAuthorAlert() {
        let alert = UIAlertController(
            title: "New Author",
            message: "Enter author name",
            preferredStyle: .alert
        )

        alert.addTextField { textField in
            textField.placeholder = "Author name"
        }

        let save = UIAlertAction(title: "Save", style: .default) { _ in
            let name = alert.textFields?.first?.text ?? ""
            if !name.isEmpty {
                self.createAuthor(name: name)
            }
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(save)
        alert.addAction(cancel)

        present(alert, animated: true)
    }


}

extension AuthorListVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        authors.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = authors[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(
            withIdentifier: "BookListViewController"
        ) as! BookListViewController

        vc.author = authors[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
