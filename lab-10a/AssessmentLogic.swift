
import Foundation

// Grade Calculator

struct GradeCalculator {

    static func calculateGrade(for marks: Double) -> String? {

        // Marks should always be between 0 and 100.
        guard marks.isFinite, (0...100).contains(marks) else {
            return nil
        }

        switch marks {
        case 90...100:
            return "A"
        case 80..<90:
            return "B"
        case 70..<80:
            return "C"
        case 60..<70:
            return "D"
        default:
            return "F"
        }
    }
}


// Registration Form Validation

struct RegistrationValidator {

    static func validate(name: String, email: String) -> Bool {

        let cleanedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)

        // Name cannot be empty.
        guard !cleanedName.isEmpty else {
            return false
        }

        // Check the basic email format.
        let emailParts = cleanedEmail.split(
            separator: "@",
            omittingEmptySubsequences: false
        )

        guard emailParts.count == 2 else {
            return false
        }

        let username = emailParts[0]
        let domain = emailParts[1]

        guard !username.isEmpty,
              !domain.isEmpty,
              domain.contains("."),
              !cleanedEmail.contains(" ") else {
            return false
        }

        return true
    }
}


//Course Model

struct Course: Identifiable, Equatable {

    let id: UUID
    var title: String

    init(id: UUID = UUID(), title: String) {
        self.id = id
        self.title = title
    }
}


// Course ViewModel

final class CourseViewModel {

    private(set) var favouriteCourseIDs: Set<UUID> = []

    // Add a course to favourites or remove it if already present.
    func toggleFavourite(for course: Course) {

        if favouriteCourseIDs.contains(course.id) {
            favouriteCourseIDs.remove(course.id)
        } else {
            favouriteCourseIDs.insert(course.id)
        }
    }

    func isFavourite(_ course: Course) -> Bool {
        return favouriteCourseIDs.contains(course.id)
    }
}
