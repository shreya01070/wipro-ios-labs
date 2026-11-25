
import SwiftUI

struct CourseRowView: View {

    let course: Course

    @Binding var isFavorite: Bool

    var body: some View {

        HStack(spacing: 12) {

            NavigationLink(value: course) {

                HStack(spacing: 12) {

                    Image(systemName: course.imageName)
                        .font(.system(size: 25))
                        .foregroundColor(.blue)
                        .frame(width: 50, height: 50)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)

                    VStack(alignment: .leading, spacing: 5) {

                        Text(course.name)
                            .font(.headline)
                            .foregroundColor(.primary)

                        Text(course.category)
                            .font(.caption)
                            .foregroundColor(.blue)

                        Text(course.instructor)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }

                    Spacer(minLength: 5)
                }
            }
            .buttonStyle(.plain)

            FavoriteButtonView(isFavorite: $isFavorite)
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    NavigationStack {
        CourseRowView(
            course: Course.sampleCourses[0],
            isFavorite: .constant(false)
        )
        .padding()
    }
}

