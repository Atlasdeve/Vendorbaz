import SwiftUI
import WebKit
import UIKit

// Define the WebView as a separate SwiftUI view
struct WebView: UIViewRepresentable {
    let url: URL?

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Delay to show launch screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // 1 second delay
            self.checkNetworkAndTransition()
        }
    }

    private func checkNetworkAndTransition() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController: UIViewController

        if NetworkManager.shared.isConnected {
            // Network is connected, show the main screen
            // Assuming ContentView is a SwiftUI view to be shown using UIHostingController
            let url = URL(string: "https://vendorbaz.com") // Replace with your URL
            let webView = WebView(url: url)
            let hostingController = UIHostingController(rootView: webView)
            nextViewController = hostingController
        } else {
            // No network connection, show the no connection screen
            nextViewController = storyboard.instantiateViewController(withIdentifier: "NoConnectionViewControllerID")
        }

        // Transition to the next view controller
        UIView.transition(with: self.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.present(nextViewController, animated: false, completion: nil)
        }, completion: nil)
    }
}
