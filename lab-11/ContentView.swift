
import SwiftUI

// Course Model

struct Course: Identifiable {
    let id: Int
    let title: String
    let category: String
    let duration: String
    let level: String

    static func makeSampleData(count: Int) -> [Course] {

        let titles = [
            "Introduction to Swift",
            "iOS App Development",
            "Data Structures",
            "Object Oriented Programming",
            "Mobile UI Design",
            "Advanced SwiftUI",
            "Database Management",
            "Software Engineering"
        ]

        let categories = [
            "Programming",
            "Development",
            "Design",
            "Computer Science"
        ]

        let levels = ["Beginner", "Intermediate", "Advanced"]

        return (1...count).map { index in
            Course(
                id: index,
                title: titles[(index - 1) % titles.count] + " \(index)",
                category: categories[(index - 1) % categories.count],
                duration: "\(2 + index % 8) weeks",
                level: levels[(index - 1) % levels.count]
            )
        }
    }
}

//  Rendering Mode

enum RenderingMode: String, CaseIterable, Identifiable {
    case baseline = "Baseline"
    case optimized = "Optimized"

    var id: String { rawValue }
}

// Main Screen

struct ContentView: View {

    @State private var searchText = ""
    @State private var renderingMode: RenderingMode = .baseline

    // Keeping the same dataset makes both modes easier to compare.
    private static let sampleCourses = Course.makeSampleData(count: 3000)

    private var filteredCourses: [Course] {
        let search = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !search.isEmpty else {
            return Self.sampleCourses
        }

        return Self.sampleCourses.filter {
            $0.title.localizedCaseInsensitiveContains(search) ||
            $0.category.localizedCaseInsensitiveContains(search)
        }
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {

                // Screen heading
                VStack(alignment: .leading, spacing: 5) {
                    Text("Course Explorer")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Explore and discover available courses.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 10)

                // Search field
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)

                    TextField("Search courses...", text: $searchText)
                        .accessibilityIdentifier("courseSearchField")

                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                        }
                        .accessibilityLabel("Clear search")
                    }
                }
                .padding(12)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))

                // Switch between the two implementations
                VStack(alignment: .leading, spacing: 8) {
                    Text("Performance comparison")
                        .font(.headline)

                    Picker("Rendering mode", selection: $renderingMode) {
                        ForEach(RenderingMode.allCases) { mode in
                            Text(mode.rawValue).tag(mode)
                        }
                    }
                    .pickerStyle(.segmented)
                    .accessibilityIdentifier("renderingModePicker")

                    Text(
                        renderingMode == .baseline
                        ? "VStack creates all rows immediately."
                        : "LazyVStack creates rows as they appear."
                    )
                    .font(.caption)
                    .foregroundColor(.secondary)
                }

                // Course count
                HStack {
                    Text("Available Courses")
                        .font(.headline)

                    Spacer()

                    Text("\(filteredCourses.count) courses")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                // Course list
                if filteredCourses.isEmpty {
                    ContentUnavailableView(
                        "No Courses Found",
                        systemImage: "book.closed",
                        description: Text("Try searching with another keyword.")
                    )
                } else {
                    ScrollView {
                        if renderingMode == .baseline {

                            // Baseline implementation:
                            // All course rows are created eagerly.
                            VStack(spacing: 10) {
                                ForEach(filteredCourses) { course in
                                    CourseRow(course: course)
                                }
                            }

                        } else {

                            // Optimized implementation:
                            // Rows are created when they are needed.
                            LazyVStack(spacing: 10) {
                                ForEach(filteredCourses) { course in
                                    CourseRow(course: course)
                                }
                            }
                        }
                    }
                    .accessibilityIdentifier("courseList")
                }

                Spacer(minLength: 0)
            }
            .padding()
            .navigationTitle("My Courses")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//Reusable Course Row

struct CourseRow: View {

    let course: Course

    var body: some View {
        HStack(spacing: 12) {

            Image(systemName: "book.closed.fill")
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 45, height: 45)
                .background(Color.blue.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 5) {

                Text(course.title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(course.category)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                HStack {
                    Text(course.duration)
                    Text("•")
                    Text(course.level)
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(12)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
