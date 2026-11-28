
import Foundation

enum ValidationHelper {

    static func validateCourseName(_ name: String) -> String? {
        let cleanedName = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if cleanedName.isEmpty {
            return "Please enter a course name."
        }

        if cleanedName.count < 2 {
            return "Course name must contain at least 2 characters."
        }

        return nil
    }

    static func validateAssignmentTitle(_ title: String) -> String? {
        let cleanedTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if cleanedTitle.isEmpty {
            return "Please enter an assignment title."
        }

        return nil
    }

    static func validateDuration(_ weeks: Int) -> String? {
        if weeks < 1 || weeks > 52 {
            return "Duration must be between 1 and 52 weeks."
        }

        return nil
    }
}
