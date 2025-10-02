import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @AppStorage("useVPN") private var useVPN: Bool = false
    @Binding var isLoading: Bool

    let localURL = "http://192.168.0.203:8013/labeldesigner"
    let vpnURL = "http://100.105.104.117:8013/labeldesigner"

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()

        // Enable caching for better performance
        let preferences = WKPreferences()
        config.preferences = preferences

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = context.coordinator

        // Load the initial URL
        let urlString = useVPN ? vpnURL : localURL
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.cachePolicy = .returnCacheDataElseLoad
            webView.load(request)
        }

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        // Only reload if the URL actually changed (VPN toggle)
        let targetURLString = useVPN ? vpnURL : localURL
        if webView.url?.absoluteString != targetURLString {
            if let url = URL(string: targetURLString) {
                var request = URLRequest(url: url)
                request.cachePolicy = .returnCacheDataElseLoad
                webView.load(request)
            }
        }
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
        }
    }
}
