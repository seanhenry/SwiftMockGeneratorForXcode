import Foundation

class GoogleAnalyticsTracker {

    private let tid = "UA-114749580-3"
//    private let tid = "UA-114749580-1" // Debug

    func track(action: String, value: Int = 0) {
        var request = URLRequest(url: URL(string: "https://www.google-analytics.com/collect")!)
        request.httpMethod = "POST"
        request.httpBody = "v=1&tid=\(tid)&cid=Xcode&t=event&ec=mock&ea=\(action)&ev=\(value)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?
            .data(using: .utf8)
        URLSession.shared.dataTask(with: request).resume()
    }
}
