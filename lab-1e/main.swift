import Foundation
// Course struct and CourseManager class
struct Course {
    var title: String
    var code: String
    var credits: Int
}
class CourseManager {
    var courseName: String

    init(courseName: String) {
        self.courseName = courseName
        print("Manager created: \(courseName)")
    }
    deinit {
        print("Manager removed: \(courseName)")
    }
}
// Value and Reference Types
func testCopy() {
    print("\n1. Struct and Class")
    var course1 = Course(title: "Math", code: "M101", credits: 4)
    var course2 = course1
    course2.title = "Physics"
    print("Original course: \(course1.title)")
    print("Copied course: \(course2.title)")
    let manager1 = CourseManager(courseName: "Math Manager")
    let manager2 = manager1
    
    manager2.courseName = "Physics Manager"
    print("Manager 1: \(manager1.courseName)")
    print("Manager 2: \(manager2.courseName)")
}
// Teacher and Classroom
class Classroom {
    var roomNumber: String
    weak var teacher: Teacher?

    init(roomNumber: String) {
        self.roomNumber = roomNumber
        print("Classroom created: \(roomNumber)")
    }
    deinit {
        print("Classroom removed: \(roomNumber)")
    }
}
class Teacher {
    var name: String
    var classroom: Classroom?

    init(name: String) {
        self.name = name
        print("Teacher created: \(name)")
    }
    deinit {
        print("Teacher removed: \(name)")
    }
}
func testOwnership() {
    print("\n2. Teacher and Classroom")
    do {
        let room = Classroom(roomNumber: "302")
        let teacher = Teacher(name: "Alan")

        room.teacher = teacher
        teacher.classroom = room
    }
    print("Both objects have been released.")
}
// Closure and Weak Self
class Department {
    var name: String
    var greeting: (() -> Void)?

    init(name: String) {
        self.name = name
        print("Department created: \(name)")
    }
      func setupGreeting() {
        greeting = { [weak self] in
            guard let self = self else { return }
            print("Welcome to \(self.name) department!")
        }
    }
    deinit {
        print("Department removed: \(name)")
    }
}

func testClosure() {
    print("\n3. Closure and Weak Self")
    var department: Department? = Department(name: "Computer Science")
    department?.setupGreeting()
    department?.greeting?()
    department = nil
}
// Main program

print("Lab 1e ")

testCopy()
testOwnership()
testClosure()


