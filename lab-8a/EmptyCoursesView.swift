
import SwiftUI

struct EmptyCoursesView: View {

    var body: some View {

        VStack(spacing: 15) {

            Image(systemName: "book.closed")
                .font(.system(size: 45))
                .foregroundColor(.gray)

            Text("No Courses Available")
                .font(.title3)
                .fontWeight(.semibold)

            Text("There are no courses in this category right now.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 50)
    }
}

#Preview {
    EmptyCoursesView()
}
