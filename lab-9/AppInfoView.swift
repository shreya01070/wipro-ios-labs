
import SwiftUI

struct AppInfoView: View {

    // Read values from the application bundle
    private var appName: String {

        Bundle.main.object(
            forInfoDictionaryKey: "CFBundleDisplayName"
        ) as? String ?? "My iOS App"
    }

    private var bundleIdentifier: String {

        Bundle.main.bundleIdentifier ?? "Not available"
    }

    private var appVersion: String {

        Bundle.main.object(
            forInfoDictionaryKey: "CFBundleShortVersionString"
        ) as? String ?? "Not set"
    }

    private var buildNumber: String {

        Bundle.main.object(
            forInfoDictionaryKey: "CFBundleVersion"
        ) as? String ?? "Not set"
    }

    var body: some View {

        List {

            Section(header: Text("Application Information")) {

                infoRow(
                    title: "App Name",
                    value: appName
                )

                infoRow(
                    title: "Bundle Identifier",
                    value: bundleIdentifier
                )

                infoRow(
                    title: "Version",
                    value: appVersion
                )

                infoRow(
                    title: "Build Number",
                    value: buildNumber
                )
            }

            Section(header: Text("Privacy")) {

                Label(
                    "No sensitive permissions required",
                    systemImage: "lock.shield"
                )
                .foregroundColor(.green)

                Text("This application displays basic app information and does not access private user data.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("App Information")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Reusable information row
    private func infoRow(
        title: String,
        value: String
    ) -> some View {

        VStack(alignment: .leading, spacing: 5) {

            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)

            Text(value)
                .font(.body)
                .textSelection(.enabled)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        AppInfoView()
    }
}
