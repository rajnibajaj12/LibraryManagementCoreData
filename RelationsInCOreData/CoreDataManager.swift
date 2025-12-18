//
//  CoreDataManager.swift
//  RelationsInCOreData
//
//  Created by Rajni on 18/12/25.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()
    private init() {}

    var context: NSManagedObjectContext {
        UIApplication.context
    }

    // MARK: - Create Author
    func createAuthor(name: String) -> Author {
        let author = Author(context: context)
        author.id = UUID()
        author.name = name
        saveContext()
        return author
    }

    // MARK: - Create Book
    func createBook(title: String, price: Double, author: Author) {
        let book = LibraryBook(context: context)
        book.id = UUID()
        book.title = title
        book.price = price
        book.author = author
        saveContext()
    }

    // MARK: - Fetch Authors
    func fetchAuthors() -> [Author] {
        let request: NSFetchRequest<Author> = Author.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }

    // MARK: - Delete Author
    func deleteAuthor(_ author: Author) {
        context.delete(author)
        saveContext()
    }

    // MARK: - Save
    func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }
}


enum RelationType {
    case oneToMany
    case manyToMany
    case oneToOne
}
