import Foundation
//safe wrapping
let studentMarks = ["100": 85,
                    "200": 92,
                    "300": 78,
                    "400": 90]
//find marks using students ID
func findMarks(for id: String) -> Int?{
  return studentMarks[id]
}
//checking value using if let
func checkStudent(id: String){
  print("checking student ID: \(id)")

  if let marks = findMarks(for: id){
    print("Marks: \(marks)")
  }else{
    print("student not found")
  }
}
//checking value using guard let
func showStudentDetails(id: String){
  guard let marks = findMarks(for:id)else{
    print("no student found with ID: \(id)")
    return
  }
  print("Student marks: \(marks)")
}
//empty and nil input
func processInput(_ text: String?) -> String{
  guard let input = text,
    !input.trimmingCharacters(in:.whitespaces).isEmpty 
  else{
    print("Empty input received")
    return "N/A"
  }
  return input
}
//structure for optional chaining
struct School{
  var principalName: String?
}
struct Department{
  var school: School?
}
//user profile with required and optional properties
struct UserProfile{
  var name: String
  var address: String?
  var phone: String?
}
//Testing the functions
print("1. Dictionary lookup and if let")
checkStudent(id: "S200")
checkStudent(id: "s999")
print("\n2. Using guard let")
showStudentDetails(id: "S100")
showStudentDetails(id: "BAD_ID")
print("\n3. Handling Text Input")
let name: String? = "john"
let emptyText = " "
print("Result: \(processInput(name))")
print("Result: \(processInput(emptyText))")
print("Result: \(processInput(nil))")
print("\n4. Optional Chaining and Nil Coalescing")
   let engineeringDept = Department(school: School(principalName: "Dr. Smith"))
      let artsDept = Department(school: nil)
      let principal1 = 
      engineeringDept.school?.principalName ?? "Not assigned"
      let principal2 = 
      artsDept.school?.principalName ?? "Not assigned"

      print("Engineering Department: \(principal1)")
      print("Arts Depatment: \(principal2)")

      print("\n5.User Profile")
      let user1 = UserProfile(name: "alien",address: "123 xyz street",phone: nil)
      let user2 = UserProfile(name: "trump",address: nil,phone: "555-1234")
      print("Name: \(user1.name)")
      print("Address: \(user1.address ?? "Not provided")")
      print("phone: \(user1.phone ?? "Not provided")")
      print("Name: \(user2.name)")
      print("Address: \(user2.address ?? "Not provided")")
      print("phone: \(user2.phone ?? "Not provided")")
      
      
      
                                       

      


