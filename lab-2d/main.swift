import Foundation
// Creating errors for student validation
enum ValidationError: Error {
    case emptyName
    case invalidMark
    case invalidID
}
// Student details and registration function
struct Student {
    let id: Int
    let name: String
    let mark: Int
}
func registerStudent(id: Int, name: String, mark: Int) throws -> Student {
// Checking if the ID is valid
    if id <= 0 {
        throw ValidationError.invalidID
    }
// Removing extra spaces from the name
    let studentName = name.trimmingCharacters(in: .whitespaces)
    if studentName.isEmpty {
        throw ValidationError.emptyName
    }
 // Marks should be between 0 and 100
    if mark < 0 || mark > 100 {
        throw ValidationError.invalidMark
    }
    return Student(id: id, name: studentName, mark: mark)
}

// Testing the registration function
print("Testing Student Registration")
let testCases: [(id: Int, name: String, mark: Int)] = [
    (101, "trump", 85),
    (0, "Amit", 90),
    (102, "   ", 75),
    (103, "modi", 120)
]
for test in testCases {
    do {
        let student = try registerStudent(
            id: test.id,
            name: test.name,
            mark: test.mark
        )
        print("Student \(student.name) registered successfully.")
        print("ID: \(student.id), Marks: \(student.mark)\n")
    } catch ValidationError.invalidID {
        print("Registration failed: Please enter a valid ID.\n")
    } catch ValidationError.emptyName {
        print("Registration failed: Name cannot be empty.\n")
    } catch ValidationError.invalidMark {
        print("Registration failed: Marks should be between 0 and 100.\n")
    } catch {
        print("Something went wrong: \(error)\n")
    }
}

//Different ways of handling errors
print("Comparing Error Handling Methods")

// Using throws
func parseAgeThrowing(_ text: String) throws -> Int {
    guard let age = Int(text), age >= 0 else {
        throw ValidationError.invalidMark
    }
    return age
}

// Using optional
func parseAgeOptional(_ text: String) -> Int? {
    guard let age = Int(text), age >= 0 else {
        return nil
    }
    return age
}

// Using Result
func parseAgeResult(_ text: String) -> Result<Int, Error> {
    guard let age = Int(text), age >= 0 else {
        return .failure(ValidationError.invalidMark)
    }
    return .success(age)
}
print("Optional result: \(parseAgeOptional("abc") ?? -1)")

//Handling errors without crashing the program

print("\nSafe Registration Test")
let safeStudent = try? registerStudent(
    id: -5,
    name: "Crash Test",
    mark: 50
)
if let student = safeStudent {
    print("Student registered: \(student.name)")
} else {
    print("Invalid details entered. The program handled the error safely.")
}


