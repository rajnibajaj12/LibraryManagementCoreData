### **📱 Core Data Relationships Demo (Swift – UIKit)**

A step-by-step demo project to understand Core Data implementation and relationships using Swift & UIKit.
This project explains One-to-One, One-to-Many, and Many-to-Many relationships with real-world examples and clean architecture.

## **🧠 What You Will Learn**

- How to add Core Data to a UIKit project

- Creating Entities & Relationships

- Generating NSManagedObject subclasses

- Avoiding duplicate records

- Fetching related objects

- Writing reusable Core Data functions

- Clean data flow between ViewControllers
  
- Implementing: One-to-One, One-to-Many, Many-to-Many relationships


## **🏗️ Project Use Case** 

📚 Author ↔ Book (One-to-Many)

One Author can write multiple Books

Each Book belongs to one Author

🎓 Student ↔ Course (Many-to-Many)

One Student can enroll in multiple Courses

One Course can have multiple Students



## **📂 Project Structure**

<img width="437" height="378" alt="Screenshot 2025-12-19 at 2 01 47 AM" src="https://github.com/user-attachments/assets/734d2aed-9812-4213-ad8b-4489c01c8edc" />


### **⚙️ How to Add Core Data to a New Project**

1. Create a new UIKit App

2. While creating the project:

  - ✅ Check Use Core Data

3. Xcode automatically creates:

NSPersistentContainer , .xcdatamodeld file


<img width="400" height="519" alt="Screenshot 2025-12-18 at 5 21 58 PM" src="https://github.com/user-attachments/assets/c8460996-08b8-409e-b175-19ad3266edcf" />




4. Creating Entities & Relationships

 -  Example: Author ↔ Book

     Author Entity

        name: String

        Relation  books → Book (To-Many)

   Book Entity

      title: String

      Relation author → Author (To-One)

   ✅ Set Inverse Relationship
   ✅ Set Delete Rule = Cascade


<img width="500" height="600" alt="Screenshot 2025-12-19 at 1 42 25 AM" src="https://github.com/user-attachments/assets/a5ea6f27-c814-45d7-97b1-ed8dcea01847" />



- Example: Student ↔ Course (Many-to-Many)

    Entity :  Student

       Attribute :  name: String

      Relation :  courses → Course (To-Many)

   Entity :   Course

       Attribute :    title: String

      Relation :    students → Student (To-Many)


<img width="500" height="600" alt="Screenshot 2025-12-18 at 5 34 58 PM" src="https://github.com/user-attachments/assets/a5c9796a-5b20-420a-8af7-d8c72f733b60" />


## **🧬 Important Core Data Code**

Save Context

```swift

func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
        try? context.save()
    }
}

```

Fetch or Create (Avoid Duplicate Course)

```swift

 func fetchAuthors() -> [Author] {
        let request: NSFetchRequest<Author> = Author.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }

```

## **🎥 Demo Video**

▶️ Watch Full Explanation Video
Click here to watch the demo video


https://github.com/user-attachments/assets/b040c81e-1ff1-4394-827c-e8a7f52ffda2



## **📌 Key Takeaways**

- Core Data handles relationships efficiently

- Inverse relationships are critical

- Fetch-or-Create pattern avoids duplicates

- One data model can support complex UI flows

🙌 Conclusion

This project is created for learning, demonstration, and interviews.
It provides a clear understanding of Core Data relationships with real-world examples.

## **🛠 How to Run**

- Clone this repository

- Open project in Xcode

- Run on simulator or iPhone

## **👨‍💻 Author**

**Rajni Bala**

iOS Developer | UIKit | Swift | Core Data | Relations
