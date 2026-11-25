
import Foundation

struct Course: Identifiable, Hashable {

    let id: Int
    let name: String
    let category: String
    let instructor: String
    let duration: String
    let level: String
    let description: String
    let imageName: String

    var isFavorite: Bool

    static let sampleCourses = [

        Course(
            id: 1,
            name: "SwiftUI Development",
            category: "iOS Development",
            instructor: "John Smith",
            duration: "8 Weeks",
            level: "Beginner",
            description: "Learn how to build modern iOS applications using SwiftUI. This course covers layouts, views, navigation and state management.",
            imageName: "iphone",
            isFavorite: false
        ),

        Course(
            id: 2,
            name: "UIKit Fundamentals",
            category: "iOS Development",
            instructor: "David Miller",
            duration: "6 Weeks",
            level: "Intermediate",
            description: "Understand UIKit components, view controllers and navigation while building iOS interfaces.",
            imageName: "apps.iphone",
            isFavorite: false
        ),

        Course(
            id: 3,
            name: "Java Programming",
            category: "Programming",
            instructor: "Michael Brown",
            duration: "10 Weeks",
            level: "Intermediate",
            description: "Learn Java fundamentals, object-oriented programming, collections and exception handling.",
            imageName: "cup.and.saucer",
            isFavorite: false
        ),

        Course(
            id: 4,
            name: "Python Programming",
            category: "Programming",
            instructor: "Sarah Wilson",
            duration: "5 Weeks",
            level: "Beginner",
            description: "Get started with Python and understand variables, loops, functions and problem solving.",
            imageName: "terminal",
            isFavorite: false
        ),

        Course(
            id: 5,
            name: "Web Development",
            category: "Web Development",
            instructor: "Emma Johnson",
            duration: "8 Weeks",
            level: "Beginner",
            description: "Learn HTML, CSS and JavaScript to create responsive and interactive websites.",
            imageName: "globe",
            isFavorite: false
        )
    ]
}
