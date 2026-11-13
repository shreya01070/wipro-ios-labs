import Foundation
// Using Protocols
protocol Displayable {
    var displayDetails: String { get }
}
struct Student: Displayable {
    let name: String
    let rollNo: Int
     var displayDetails: String {
        return "Student: \(name), Roll No: \(rollNo)"
    }
}
struct Course: Displayable {
    let title: String
    let code: String
    var displayDetails: String {
        return "Course: \(title), Code: \(code)"
    }
}
let student = Student(name: "Rahul", rollNo: 102)
let course = Course(title: "Swift Programming", code: "SW101")

print("1. Student and Course Details:")
print(student.displayDetails)
print(course.displayDetails)

//Extension of String
extension String {
    var isValidEmail: Bool {
        return self.contains("@") && self.contains(".")
    }
}
let email1 = "rahul@gmail.com"
let email2 = "notanemail.com"

print("\n2. Email Validation:")
print("\(email1): \(email1.isValidEmail)")
print("\(email2): \(email2.isValidEmail)")

// Creating a Generic Stack
struct Stack<T> {
    var items: [T] = []
    mutating func push(_ item: T) {
        items.append(item)
    }
    mutating func pop() -> T? {
        return items.popLast()
    }
    func peek() -> T? {
        return items.last
    }
    var isEmpty: Bool {
        return items.isEmpty
    }
}
print("\n3. Generic Stack:")

var stack = Stack<Int>()

stack.push(10)
stack.push(20)
stack.push(30)

print("Top element:", stack.peek() ?? 0)
print("Removed element:", stack.pop() ?? 0)
print("Is stack empty?", stack.isEmpty)

//Generic Function with Protocol
protocol Describable {
    func describe()
}
struct Book: Describable {
    let title: String
    func describe() {
        print("Book name: \(title)")
    }
}
func printDescription<T: Describable>(item: T) {
    item.describe()
}
print("\n4. Protocol Constraint:")
let book = Book(title: "Data Structures in Swift")
printDescription(item: book)

// Extensions and Stored Properties
print("\n5. Stored Properties in Extensions:")

print("""
Swift extensions cannot add stored properties to an existing type.
They can add computed properties, methods and initializers.
If we want to store new data, we need to modify the original type
or create a new type
""")

