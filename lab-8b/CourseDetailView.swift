
import SwiftUI

struct CourseDetailView: View {

    let course: Course

    @Environment(\.dismiss) private var dismiss

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 22) {

                // Course image
                ZStack {

                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.blue.opacity(0.12))
                        .frame(height: 170)

                    Image(systemName: course.imageName)
                        .font(.system(size: 65))
                        .foregroundColor(.blue)
                }

                // Course name and category
                VStack(alignment: .leading, spacing: 8) {

                    Text(course.name)
                        .font(.title)
                        .fontWeight(.bold)

                    Text(course.category)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }

                Divider()

                // Course information
                VStack(alignment: .leading, spacing: 18) {

                    informationRow(
                        title: "Instructor",
                        value: course.instructor,
                        icon: "person"
                    )

                    informationRow(
                        title: "Duration",
                        value: course.duration,
                        icon: "clock"
                    )

                    informationRow(
                        title: "Difficulty",
                        value: course.level,
                        icon: "chart.bar"
                    )
                }

                Divider()

                // Course description
                VStack(alignment: .leading, spacing: 10) {

                    Text("About this course")
                        .font(.headline)

                    Text(course.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineSpacing(5)
                }
            }
            .padding(20)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)

        .toolbar {

            ToolbarItem(placement: .topBarTrailing) {

                Button("Back to Courses") {
                    dismiss()
                }
            }
        }
    }

    // Information Row

    private func informationRow(
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
