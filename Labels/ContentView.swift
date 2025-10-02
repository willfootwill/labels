import SwiftUI

struct ContentView: View {
    @State private var showSettings = false
    @State private var isLoading = true

    var body: some View {
        ZStack {
            WebView(isLoading: $isLoading)
                .edgesIgnoringSafeArea(.all)

            // Loading indicator
            if isLoading {
                VStack {
                    ProgressView()
                        .scaleEffect(2)
                        .padding()
                    Text("Loading Label Designer...")
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white.opacity(0.9))
            }

            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showSettings.toggle()
                    }) {
                        Image(systemName: "gear")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                    .padding()
                }
                Spacer()
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
}
