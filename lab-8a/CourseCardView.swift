
import SwiftUI

struct CourseCardView: View {

    let course: Course

    var body: some View {

        HStack(spacing: 15) {

            // Course icon
            ZStack {

                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.blue.opacity(0.12))
                    .frame(width: 65, height: 65)

                Image(systemName: course.symbol)
                    .font(.system(size: 27))
                    .foregroundColor(.blue)
            }

            // Course information
            VStack(alignment: .leading, spacing: 7) {

                Text(course.name)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(course.category)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.blue)

                Text("By \(course.instructor)")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(course.duration)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.secondarySystemGroupedBackground))
        )
    }
}

#Preview {
    CourseCardView(course: Course.sampleCourses[0])
        .padding()
}
