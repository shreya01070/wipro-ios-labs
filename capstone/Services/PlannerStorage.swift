
import Foundation

final class PlannerStorage {

    private let defaults: UserDefaults

    private let coursesKey = "savedCourses"
    private let assignmentsKey = "savedAssignments"

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    var hasStoredData: Bool {
        return defaults.object(forKey: coursesKey) != nil
            || defaults.object(forKey: assignmentsKey) != nil
    }

    func loadCourses() -> [Course] {
        guard let data = defaults.data(forKey: coursesKey) else {
            return []
        }

        do {
            return try JSONDecoder().decode([Course].self, from: data)
        } catch {
            print("Could not load courses: \(error)")
            return []
        }
    }

    func saveCourses(_ courses: [Course]) {
        do {
            let data = try JSONEncoder().encode(courses)
            defaults.set(data, forKey: coursesKey)
        } catch {
            print("Could not save courses: \(error)")
        }
    }

    func loadAssignments() -> [Assignment] {
        guard let data = defaults.data(forKey: assignmentsKey) else {
            return []
        }

        do {
            return try JSONDecoder().decode(
                [Assignment].self,
                from: data
            )
        } catch {
            print("Could not load assignments: \(error)")
            return []
        }
    }

    func saveAssignments(_ assignments: [Assignment]) {
        do {
            let data = try JSONEncoder().encode(assignments)
            defaults.set(data, forKey: assignmentsKey)
        } catch {
            print("Could not save assignments: \(error)")
        }
    }
}
