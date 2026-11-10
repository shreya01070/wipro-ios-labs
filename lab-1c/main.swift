import Foundation
//working with an array
print("Courses")
var courses = ["data Structures","Algorithms","Database System","Operating System"]

//add new course
courses.append("Computer Networks")
//remove operating system
if let index = courses.firstIndex(of: "Operating System"){
  courses.remove(at: index)
}
//sorting courses
courses.sort()
print("Available courses: \(courses)")

//courses starting with d
let dcourses = courses.filter { $0.hasPrefix("D") }
print("Courses starting with D: \(dcourses)")

//chech for algo
if courses.contains("Algorithms"){
  print("Algorithms is available")
}
// student Ids
print("\nStudent IDs")
let ids = [100,200,300,400,200,600]
let uniqueIDs = Set(ids)
print("All IDs: \(ids)")
print("IDs without duplicates: \(uniqueIDs)")
print("Number of unique students: \(uniqueIDs.count)")

//student marks
print("\nStudents Marks")
let marks = [100:81,200:89,300:95,400:47,600:78]
//student with highest marks
if let topper =  marks.max(by: {$0.value < $1.value }){
  print("Toppers ID: \(topper.key)")
  print("Highest marks: \(topper.value)")
}

//failed students
let passingMarks = 50
let failedStudents = marks.filter {$0.value < passingMarks}
print("students who scored less than 50")
for student in failedStudents{
  print("StudentID: \(student.key),Marks: \(student.value)")
}

//order status
print("\nOrder Status")
enum OrderStatus{
  case received
  case processing
  case outForDelivery
  case delivered
}
let currentStatus = OrderStatus.outForDelivery
func checkStatus(_ status: OrderStatus){
  switch status{
    case.received:
    print("your order has been received")
    case.processing:
    print("your order is been packed")
    case.outForDelivery:
    print("your order is out for delivery")
    case.delivered:
    print("your order has been delivered")
  }
}
checkStatus(currentStatus)
//checking API
print("\nAPI Result")
enum APIResult{
  case success(data: String)
  case failure(errorCode: Int, message: String)
}
func showResult(_ result: APIResult){
  switch result{
    case.success(let data):
    print("Data loaded successfully: \(data)")
    case.failure(let code, let message):
    print("Error code: \(code)")
    print("Message: \(message)")
  }
}
let response = APIResult.success(data: "User profile loaded")
showResult(response)
    




