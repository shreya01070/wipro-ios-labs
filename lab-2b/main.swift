import Foundation
print("Lab 2b - Closures\n")
//  Sorting students using closure
print("1. Student scores:")
struct Student {
    let name: String
    let score: Int
}
let students = [
    Student(name: "Rahul", score: 85),
    Student(name: "Ananya", score: 92),
    Student(name: "Karan", score: 78),
    Student(name: "Priya", score: 95)
]
let sortedStudents = students.sorted {
    $0.score > $1.score
}
for student in sortedStudents {
    print("\(student.name): \(student.score)")
}
//  Completion closure
print("\n2. Download status:")
func downloadData(completion: (Bool) -> Void) {
    print("Downloading data...")
    let success = true
    completion(success)
}
downloadData { success in
    if success {
        print("Download completed successfully!")
    } else {
        print("Download failed.")
    }
}
// Trailing closure and shorthand arguments
print("\n3. Sorting numbers:")
let numbers = [5, 2, 9, 1, 7]
let sortedNumbers = numbers.sorted {
    $0 < $1
}
print("Using shorthand: \(sortedNumbers)")
let sortedAgain = numbers.sorted(by: { num1, num2 in
    num1 < num2
})
print("Using argument names: \(sortedAgain)")

//Counter using captured variable
print("\n4. Counter example:")
func makeCounter() -> () -> Int {
    var count = 0

    let counter = {
        count += 1
        return count
    }
    return counter
}
let counter = makeCounter()
print("Count:", counter())
print("Count:", counter())
print("Count:", counter())

// Using weak self to avoid retain cycles
print("\n5. Weak self example:")
class NetworkManager {
  var onComplete: (() -> Void)?
    func fetchData() {
        onComplete = { [weak self] in
            guard let self = self else {
                return
            }
            print("Data fetched successfully.")
        }
    }
    deinit {
        print("NetworkManager object released.")
    }
}
var manager: NetworkManager? = NetworkManager()

manager?.fetchData()
manager?.onComplete?()
manager = nil
print("\nLab 2b Completed")
