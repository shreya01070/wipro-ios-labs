import Foundation
let name = "aman"
let rollno = 34
let attendance = 75

var marks = [78,85,92,65,88]
let total = marks.reduce(0,+)
let percent = (Double(total) / 500) * 100

let bonus: Double = 5
let updatedMath = Double(marks[0]) + bonus
let passedAll = marks.allSatisfy { $0 >= 40 } && attendance >= 75

print("Student: \(name) | Total:\(total)/500 | percentage: \(percent)%")
print("passed: \(passedAll ? "yes" : "no" )")
print("Math with bonus: \(updatedMath)")


