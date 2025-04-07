import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {
    
    override func isContentValid() -> Bool {
        return true
    }
    
    override func didSelectPost() {
        let appGroupID = "group.com.Linky.shared"
        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
            for provider in item.attachments ?? [] {
                if provider.hasItemConformingToTypeIdentifier("public.url") {
                    provider.loadItem(forTypeIdentifier: "public.url", options: nil) { (urlData, error) in
                        if let url = urlData as? URL {
                            print("공유된 URL: \(url.absoluteString)")
                            
                            if let userDefaults = UserDefaults(suiteName: appGroupID) {
                                var queue = userDefaults.stringArray(forKey: "sharedQueue") ?? []
                                if !queue.contains(url.absoluteString) {
                                    queue.append(url.absoluteString)
                                    userDefaults.set(queue, forKey: "sharedQueue")
                                    userDefaults.synchronize()
                                }
                            }
                        }
                        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
                    }
                    return
                }
            }
        }
    }
    
    override func configurationItems() -> [Any]! {
        return []
    }
}
