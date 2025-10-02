import SwiftUI

struct SettingsView: View {
    @AppStorage("useVPN") private var useVPN: Bool = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Connection Settings")) {
                    Toggle("Use Tailscale VPN", isOn: $useVPN)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Current URL:")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(useVPN ? "http://100.105.104.117:8013/labeldesigner" : "http://192.168.0.203:8013/labeldesigner")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 4)
                }

                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
