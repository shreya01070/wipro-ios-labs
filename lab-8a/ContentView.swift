
import SwiftUI

struct ContentView: View {

    @State private var selectedCategory = "All"

    private let categories = [
        "All",
        "iOS",
        "Programming",
        "Web",
        "Design"
    ]

    private let courses = Course.sampleCourses

    // Filter courses according to the selected category
    private var filteredCourses: [Course] {

        if selectedCategory == "All" {
            return courses
        }

        return courses.filter {
            $0.category == selectedCategory
        }
    }

    var body: some View {

        NavigationStack {

            VStack(alignment: .leading, spacing: 18) {

                // App heading
                appHeader

                // Category selection
                categorySection

                // Course list
                courseList
            }
            .padding(.top, 15)
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
            .navigationDestination(for: Course.self) { course in

                CourseDetailView(course: course)
            }
        }
    }

    // App Header

    private var appHeader: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text("Course Explorer")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Find the right course for your learning journey.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 18)
    }

    //  Category Section

    private var categorySection: some View {

        VStack(alignment: .leading, spacing: 12) {

            Text("Categories")
                .font(.headline)
                .padding(.horizontal, 18)

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 10) {

                    ForEach(categories, id: \.self) { category in

                        CategoryChipView(
                            title: category,
                            isSelected: selectedCategory == category
                        ) {

                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal, 18)
            }
        }
    }

    // Course List

    private var courseList: some View {

        VStack(alignment: .leading, spacing: 10) {

            Text("Available Courses")
                .font(.headline)
                .padding(.horizontal, 18)

            List {

                if filteredCourses.isEmpty {

                    EmptyCoursesView()
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)

                } else {

                    ForEach(filteredCourses) { course in

                        NavigationLink(value: course) {

                            CourseCardView(course: course)
                        }
                        .buttonStyle(.plain)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .listRowInsets(
                            EdgeInsets(
                                top: 7,
                                leading: 15,
                                bottom: 7,
                                trailing: 15
                            )
                        )
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    ContentView()
}
