import SwiftUI

struct ContentView: View {
    @State private var userName = ""
    @State private var message = "Hello, Stranger!"

    var body: some View {
        VStack(spacing: 20) {

            Text("SwiftUI Demo")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Enter your name", text: $userName)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Button("Click Me") {
                let enteredName = userName.trimmingCharacters(in: .whitespaces)

                if enteredName.isEmpty {
                    message = "Hello, Stranger!"
                } else {
                    message = "Hello, \(enteredName)!"
                }
            }
            .buttonStyle(.borderedProminent)

            Text(message)
                .font(.title2)
                .padding()

            Spacer()
        }
        .padding()
    }
}
