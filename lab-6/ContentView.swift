import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = PostViewModel()

    var body: some View {

        NavigationStack {

            Group {

                if viewModel.isLoading {

                    ProgressView("Loading posts...")

                } else if let message = viewModel.errorMessage {

                    VStack(spacing: 15) {

                        Text(message)
                            .multilineTextAlignment(.center)

                        Button("Try Again") {
                            Task {
                                await viewModel.loadPosts()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()

                } else {

                    List(viewModel.posts) { post in

                        NavigationLink {
                            PostDetailView(post: post)
                        } label: {

                            VStack(alignment: .leading, spacing: 8) {

                                Text(post.title.capitalized)
                                    .font(.headline)

                                Text(post.body)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
            .navigationTitle("My Posts")
            .task {
                await viewModel.loadPosts()
            }
        }
    }
}
