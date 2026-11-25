
import SwiftUI

struct CourseRowView: View {

    let course: Course

    @Binding var isFavorite: Bool

    var body: some View {

        HStack(spacing: 12) {

            // Course icon
            ZStack {

                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.12))
                    .frame(width: 55, height: 55)

                Image(systemName: course.imageName)
                    .font(.system(size: 23))
                    .foregroundColor(.blue)
            }

            // Course information
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

            Spacer()

            // Favourite button
            FavoriteButtonView(isFavorite: $isFavorite)
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    CourseRowView(
        course: Course.sampleCourses[0],
        isFavorite: .constant(false)
    )
    .padding()
}
