import SwiftUI

struct PostDetailView: View {

    let post: Post

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 20) {

                Text("Post Details")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Post ID: \(post.id)")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text(post.title.capitalized)
                    .font(.title3)
                    .fontWeight(.semibold)

                Text(post.body)
                    .font(.body)
                    .lineSpacing(6)

            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
