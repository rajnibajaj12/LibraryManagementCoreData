//
//  BookListViewController.swift
//  RelationsInCOreData
//
//  Created by Rajni on 18/12/25.
//

import UIKit
import CoreData

class BookListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

        var author: Author!
        var books: [LibraryBook] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            title = author.name
           
            tableView.delegate = self
            tableView.dataSource = self
            fetchBooks()
        }

        @IBAction func addBookTapped(_ sender: UIBarButtonItem) {
            if sender.tag == 1 {
                self.navigationController?.popViewController(animated: true )
            }else {
                showAddBookAlert()
            }
        }

        func fetchBooks() {
            books = (author.books?.allObjects as? [LibraryBook]) ?? []
            tableView.reloadData()
        }

        func createBook(title: String) {
            let book = LibraryBook(context: CoreDataManager.shared.context)
            book.title = title
            book.author = author     // ⭐ ONE-TO-MANY LINK
            CoreDataManager.shared.saveContext()
            fetchBooks()
        }
    
    func showAddBookAlert() {
        let alert = UIAlertController(
            title: "New Book",
            message: "Enter book title",
            preferredStyle: .alert
        )

        alert.addTextField { textField in
            textField.placeholder = "Book title"
        }

        let save = UIAlertAction(title: "Save", style: .default) { _ in
            let title = alert.textFields?.first?.text ?? ""
            if !title.isEmpty {
                self.createBook(title: title)
            }
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(save)
        alert.addAction(cancel)

        present(alert, animated: true)
    }



}

extension BookListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        books.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = books[indexPath.row].title
        return cell
    }
}
