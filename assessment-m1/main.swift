import Foundation
//Working with a gradebook
var gradebook: [String: [Int]] = [
    "shreya": [88, 92, 95],
    "riya": [75, 80, 82],
    "ram": [90, 85, 88]
]
func showAverage(studentName: String, grades: [String: [Int]]) {

    if let marks = grades[studentName] {
       if marks.isEmpty {
            print("\(studentName) has no grades recorded.")
            return
        }
        let totalMarks = marks.reduce(0, +)
        let average = Double(totalMarks) / Double(marks.count)
        print("\(studentName)'s average grade is: \(average)")
     } else {
        print("Student '\(studentName)' not found in the gradebook.")
    }
}

print("\n Task 1 Output ")
showAverage(studentName: "shreya", grades: gradebook)
showAverage(studentName: "ayan", grades: gradebook)

// Creating a generic stack
struct Stack<T> {
    private var items: [T] = []

    mutating func push(_ item: T) {
        items.append(item)
    }
    mutating func pop() -> T? {
        items.popLast()
    }
    var peek: T? {
        items.last
    }
}

print("\n Task 2 Output ")
// Testing the stack with numbers
var numberStack = Stack<Int>()

numberStack.push(10)
numberStack.push(20)
print("Popped from Int stack: \(numberStack.pop() ?? 0)")
// Testing the stack with strings
var wordStack = Stack<String>()

wordStack.push("Hello")
wordStack.push("Swift")
print("Popped from String stack: \(wordStack.pop() ?? "")")

// Handling retain cycles
class Person {
    var name: String
    var car: Car?

    init(name: String) {
        self.name = name
    }
    deinit {
        print("Person \(name) was deinitialized.")
    }
}
class Car {
    var model: String
  // Weak reference avoids a retain cycle.
    weak var owner: Person?

    init(model: String) {
        self.model = model
    }
    deinit {
        print("Car \(model) was deinitialized.")
    }
}

print("\n Task 3 Output ")
do {
    let person = Person(name: "John")
    let car = Car(model: "Tesla")

    person.car = car
    car.owner = person

    print("Objects created inside scope.")
}

// Username validation using error handling
enum ValidationError: Error {
    case usernameTooShort(String)
    case invalidCharacters(String)
}

func checkUsername(_ username: String) throws {

    if username.count < 4 {
        throw ValidationError.usernameTooShort(
            "Username must be at least 4 characters long."
        )
    }
     let specialCharacters = CharacterSet(
        charactersIn: "!@#$%^&*() "
    )

    if username.rangeOfCharacter(from: specialCharacters) != nil {
        throw ValidationError.invalidCharacters(
            "Username cannot contain spaces or special characters."
        )
    }
    print("Username '\(username)' is valid!")
}

print("\n Task 4 Output ")
let usernames = ["bob", "alex!", "developer_one"]
for username in usernames {

    do {
        try checkUsername(username)
    } catch ValidationError.usernameTooShort(let message) {
        print("Validation Error: \(message)")
    } catch ValidationError.invalidCharacters(let message) {
        print("Validation Error: \(message)")
    } catch {
        print("An unexpected error occurred.")
    }
}
