import Foundation

// Fetch course details after a random delay
func fetchCourseDetails(courseID: String) async throws -> String {

    let delay = UInt64.random(in: 1...3)

    // Simulating network delay
    try await Task.sleep(nanoseconds: delay * 1_000_000_000)

  
     if courseID == "bad_id" {
         throw NSError(domain: "FetchError", code: 404)
      }

    return "Course Info for ID: \(courseID) (fetched in \(delay)s)"
}


// Main function for running the program
func runCourseLab() async {

    let courseIDs = ["CS101", "MATH201", "PHYS301", "ENG102"]

    print(" Concurrent Course Fetching \n")

    let startTime = Date()

    do {
        // Fetching all courses together using a task group
        let results = try await withThrowingTaskGroup(of: String.self) { group in

            for id in courseIDs {
                group.addTask {
                    try await fetchCourseDetails(courseID: id)
                }
            }

            var courses: [String] = []

            // Collecting results as each task completes
            for try await result in group {
                courses.append(result)
            }

            return courses
        }

        print("Courses fetched successfully:\n")

        for course in results {
            print(course)
        }

    } catch {
        print("Error while fetching courses: \(error)")
    }

    let concurrentTime = Date().timeIntervalSince(startTime)

    print("\nConcurrent time: \(String(format: "%.2f", concurrentTime)) seconds")


    // Fetching the same courses one by one
    print("\n Sequential Course Fetching \n")

    let sequentialStart = Date()

    for id in courseIDs {
        do {
            let course = try await fetchCourseDetails(courseID: id)
            print(course)
        } catch {
            print("Failed to fetch \(id): \(error)")
        }
    }

    let sequentialTime = Date().timeIntervalSince(sequentialStart)

    print("\nSequential time: \(String(format: "%.2f", sequentialTime)) seconds")

    let speedup = sequentialTime / max(concurrentTime, 0.001)

    print("Speedup: Sequential fetching took approximately \(String(format: "%.1f", speedup)) times longer.")


    // Understanding task lifetime and cancellation
    print("\n Task Lifetime and Cancellation ")

    print("Tasks created inside a task group follow structured concurrency.")
    print("The task group waits for its child tasks before finishing.")
    print("If the parent task is cancelled, its child tasks also receive cancellation.")
}


// Starting the program
await runCourseLab()
