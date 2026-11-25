
import SwiftUI

struct CourseDetailView: View {

    let course: Course

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 22) {

                // Course banner
                ZStack {

                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue.opacity(0.12))
                        .frame(height: 180)

                    Image(systemName: course.symbol)
                        .font(.system(size: 65))
                        .foregroundColor(.blue)
                }

                // Course title
                VStack(alignment: .leading, spacing: 8) {

                    Text(course.name)
                        .font(.title)
                        .fontWeight(.bold)

                    Text(course.category)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.blue)
                }

                Divider()

                // Course information
                VStack(alignment: .leading, spacing: 18) {

                    detailRow(
                        title: "Instructor",
                        value: course.instructor,
                        icon: "person"
                    )

                    detailRow(
                        title: "Duration",
                        value: course.duration,
                        icon: "clock"
                    )

                    detailRow(
                        title: "Level",
                        value: course.level,
                        icon: "chart.bar"
                    )
                }

                Divider()

                // Description
                VStack(alignment: .leading, spacing: 10) {

                    Text("About this course")
                        .font(.headline)

                    Text(course.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineSpacing(5)
                }

                Spacer(minLength: 20)
            }
            .padding(20)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Reusable row for course information
    private func detailRow(
        title: String,
        value: String,
        icon: String
    ) -> some View {

        HStack(spacing: 12) {

            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 25)

            VStack(alignment: .leading, spacing: 4) {

                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(value)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }

            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        CourseDetailView(course: Course.sampleCourses[0])
    }
}
