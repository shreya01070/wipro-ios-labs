import foundation
//  Utility Functions
// average of numbers
func calculateMean(of numbers: [Double]) -> Double {
    if numbers.isEmpty {
        return 0.0
    }
    let sum = numbers.reduce(0, +)
    return sum / Double(numbers.count)
}

//  largest number in an array
func findMaximum(in numbers: [Int]) -> Int? {
    return numbers.max()
}

// Checking if the email is valid
func validateEmail(input email: String) -> Bool {
    let email = email.trimmingCharacters(in: .whitespaces)

    return email.contains("@") &&
           email.contains(".") &&
           !email.hasPrefix("@")
}

// Format first and last name
func formatDisplayName(firstName: String, lastName: String) -> String {
    let first = firstName.trimmingCharacters(in: .whitespaces).capitalized
    let last = lastName.trimmingCharacters(in: .whitespaces).capitalized

    return "\(first) \(last)"
}
// Working with Transactions
struct Transaction {
    let id: Int
    let title: String
    let amount: Double
    let isExpense: Bool
}
let transactions = [
    Transaction(id: 1, title: "Groceries", amount: 64.50, isExpense: true),
    Transaction(id: 2, title: "Monthly Salary", amount: 3200.00, isExpense: false),
    Transaction(id: 3, title: "Coffee", amount: 4.75, isExpense: true),
    Transaction(id: 4, title: "Electricity Bill", amount: 95.20, isExpense: true),
    Transaction(id: 5, title: "Freelance Work", amount: 450.00, isExpense: false)
]// Calculate the total amount spent
let totalExpenses = transactions
    .filter { $0.isExpense }
    .map { $0.amount }
    .reduce(0, +)
// Sorting Students
struct Student {
    let name: String
    let marks: Int
}
let students = [
    Student(name: "Zachary", marks: 88),
    Student(name: "Alice", marks: 92),
    Student(name: "Charlie", marks: 88),
    Student(name: "Bob", marks: 75),
    Student(name: "Diana", marks: 92)
]
// Arrange students according to their marks

let sortedStudents = students.sorted { first, second in

    if first.marks == second.marks {
        return first.name < second.name
    }
     return first.marks > second.marks
}
// Testing all the functions

print("Test Results")
print("Mean: \(calculateMean(of: [10.0, 20.0, 30.0]))")
print("Maximum: \(findMaximum(in: [4, 82, 19, 53]) ?? 0)")
print("Email Valid: \(validateEmail(input: "test@email.com"))")
print("Formatted Name: \(formatDisplayName(firstName: "john", lastName: "doe"))")
print("Total Expenses: $\(totalExpenses)")
print("Number of Students: \(sortedStudents.count)")
