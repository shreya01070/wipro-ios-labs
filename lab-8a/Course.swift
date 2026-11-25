
import Foundation

struct Course: Identifiable, Hashable {

    let id: Int
    let name: String
    let category: String
    let instructor: String
    let duration: String
    let level: String
    let description: String
    let symbol: String

    static let sampleCourses = [

        Course(
            id: 1,
            name: "SwiftUI Development",
            category: "iOS",
            instructor: "John Smith",
            duration: "8 Weeks",
            level: "Beginner",
            description: "Learn how to build modern iOS applications using SwiftUI. This course covers views, layouts, navigation and reusable components.",
            symbol: "iphone"
        ),

        Course(
            id: 2,
            name: "UIKit Fundamentals",
            category: "iOS",
            instructor: "David Miller",
            duration: "6 Weeks",
            level: "Intermediate",
            description: "Understand UIKit, view controllers, UI controls and navigation to create iOS applications.",
            symbol: "apps.iphone"
        ),

        Course(
            id: 3,
            name: "Python Programming",
            category: "Programming",
            instructor: "Sarah Wilson",
            duration: "5 Weeks",
            level: "Beginner",
            description: "Start learning Python programming with variables, loops, functions and practical examples.",
            symbol: "chevron.left.forwardslash.chevron.right"
        ),

        Course(
            id: 4,
            name: "Java Programming",
            category: "Programming",
            instructor: "Michael Brown",
            duration: "10 Weeks",
            level: "Intermediate",
            description: "Learn Java concepts including object-oriented programming, collections, exception handling and more.",
            symbol: "cup.and.saucer"
        ),

        Course(
            id: 5,
            name: "Web Development",
            category: "Web",
            instructor: "Emma Johnson",
            duration: "8 Weeks",
            level: "Beginner",
            description: "Learn HTML, CSS and JavaScript to create responsive and interactive websites.",
            symbol: "globe"
        ),

        Course(
            id: 6,
            name: "React Development",
            category: "Web",
            instructor: "Alex Wilson",
            duration: "7 Weeks",
            level: "Intermediate",
            description: "Build interactive user interfaces using React components, props, state and hooks.",
            symbol: "atom"
        )
    ]
}
