
import SwiftUI

struct AboutView: View {

    var body: some View {

        VStack(spacing: 18) {

            Image(systemName: "book.closed.fill")
                .font(.system(size: 55))
                .foregroundColor(.blue)

            Text("Course Directory")
                .font(.title)
                .fontWeight(.bold)

            Text("This application helps students explore different courses, check course information and learn about available study options.")

                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)

            Text("Built using SwiftUI")
                .font(.caption)
                .foregroundColor(.blue)
        }
        .padding()
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
