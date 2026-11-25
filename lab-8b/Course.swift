
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

    static let sampleCourses = [

        Course(
            id: 1,
            name: "SwiftUI Development",
            category: "iOS Development",
            instructor: "John Smith",
            duration: "8 Weeks",
            level: "Beginner",
            description: "Learn to create modern iOS applications using SwiftUI. Understand views, layouts, navigation and reusable components.",
            imageName: "iphone"
        ),

        Course(
            id: 2,
            name: "UIKit Fundamentals",
            category: "iOS Development",
            instructor: "David Miller",
            duration: "6 Weeks",
            level: "Intermediate",
            description: "Learn UIKit, view controllers, UI controls and navigation for building iOS applications.",
            imageName: "apps.iphone"
        ),

        Course(
            id: 3,
            name: "Java Programming",
            category: "Programming",
            instructor: "Michael Brown",
            duration: "10 Weeks",
            level: "Intermediate",
            description: "Understand Java fundamentals, object-oriented programming, collections and exception handling.",
            imageName: "cup.and.saucer"
        ),

        Course(
            id: 4,
            name: "Python Programming",
            category: "Programming",
            instructor: "Sarah Wilson",
            duration: "5 Weeks",
            level: "Beginner",
            description: "Start programming with Python and learn variables, loops, functions and basic problem solving.",
            imageName: "terminal"
        ),

        Course(
            id: 5,
            name: "Web Development",
            category: "Web Development",
            instructor: "Emma Johnson",
            duration: "8 Weeks",
            level: "Beginner",
            description: "Learn HTML, CSS and JavaScript to build responsive and interactive websites.",
            imageName: "globe"
        )
    ]
}
