
import SwiftUI

struct ContentView: View {

    @State private var courses = Course.sampleCourses

    var body: some View {

        NavigationStack {

            VStack(alignment: .leading, spacing: 15) {

                // Screen heading
                VStack(alignment: .leading, spacing: 6) {

                    Text("Course Directory")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Explore courses and improve your skills.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)

                // Course list
                List {

                    ForEach(courses) { course in

                        NavigationLink(value: course) {

                            courseRow(course)
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Courses")
            .navigationBarTitleDisplayMode(.inline)

            // Register destinations for course navigation
            .navigationDestination(for: Course.self) { selectedCourse in

                CourseDetailView(course: selectedCourse)
            }

            // Toolbar actions
            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {

                    Button {
                        courses.shuffle()
                    } label: {

                        Image(systemName: "shuffle")
                    }
                    .accessibilityLabel("Shuffle courses")
                }

                ToolbarItem(placement: .topBarLeading) {

                    NavigationLink(destination: AboutView()) {

                        Image(systemName: "info.circle")
                    }
                    .accessibilityLabel("About the app")
                }
            }
        }
    }

    // Course Row

    private func courseRow(_ course: Course) -> some View {

        HStack(spacing: 14) {

            ZStack {

                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.12))
                    .frame(width: 55, height: 55)

                Image(systemName: course.imageName)
                    .font(.system(size: 24))
                    .foregroundColor(.blue)
            }

            VStack(alignment: .leading, spacing: 6) {

                Text(course.name)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(course.category)
                    .font(.caption)
                    .foregroundColor(.blue)

                Text(course.duration)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    ContentView()
}
