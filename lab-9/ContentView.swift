
import SwiftUI

struct ContentView: View {

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(alignment: .leading, spacing: 22) {

                    // App heading
                    VStack(alignment: .leading, spacing: 8) {

                        Image(systemName: "gearshape.2.fill")
                            .font(.system(size: 42))
                            .foregroundColor(.blue)

                        Text("Project Configuration Audit")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Review your application's basic configuration and privacy information.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    // Configuration overview
                    VStack(alignment: .leading, spacing: 15) {

                        Text("Configuration Overview")
                            .font(.headline)

                        auditRow(
                            title: "Application Metadata",
                            description: "Bundle name, identifier and version",
                            icon: "app.badge.checkmark"
                        )

                        auditRow(
                            title: "Build Information",
                            description: "Version and build number",
                            icon: "hammer"
                        )

                        auditRow(
                            title: "Privacy",
                            description: "No sensitive permission is required",
                            icon: "lock.shield"
                        )

                        auditRow(
                            title: "Project Settings",
                            description: "Review deployment and signing settings in Xcode",
                            icon: "gearshape"
                        )
                    }
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(15)

                    // Navigation to app information
                    NavigationLink {

                        AppInfoView()

                    } label: {

                        HStack {

                            Image(systemName: "info.circle.fill")

                            Text("View App Information")
                                .fontWeight(.semibold)

                            Spacer()

                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                    }

                    // Privacy note
                    VStack(alignment: .leading, spacing: 8) {

                        Text("Privacy Notice")
                            .font(.headline)

                        Text("This demonstration application only reads its own bundle metadata. It does not request access to the user's photos, camera, contacts or location.")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 5)
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Audit Dashboard")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // Reusable audit information row
    private func auditRow(
        title: String,
        description: String,
        icon: String
    ) -> some View {

        HStack(spacing: 12) {

            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.blue)
                .frame(width: 35)

            VStack(alignment: .leading, spacing: 4) {

                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
