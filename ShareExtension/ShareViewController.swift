import UIKit
import Social
import MobileCoreServices
import SwiftKeychainWrapper
import Alamofire

struct SharedKeyChain {
    static let shared = KeychainWrapper(serviceName: "linky", accessGroup: "group.com.Linky.shared")
}

struct linkUser: Decodable {
    let id: Int
    let nickName: String
    let imageUri: String?
}

struct LinkResponse: Decodable {
    let id: Int
    var url: String
    let category: String
    let title: String
    let description: String
    let thumbnail: String
    let createdAt: String
    let updatedAt: String
    let user: linkUser
}

struct RefreshTokenResponse: Decodable {
    let accessToken: String
}

class ShareViewController: SLComposeServiceViewController {
    override func isContentValid() -> Bool {
        return true
    }
    
    override func didSelectPost() {
        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
            for provider in item.attachments ?? [] {
                if provider.hasItemConformingToTypeIdentifier("public.url") {
                    provider.loadItem(forTypeIdentifier: "public.url", options: nil) { (urlData, error) in
                        if let url = urlData as? URL {
                            print("공유된 URL: \(url.absoluteString)")
                            self.sendToBackend(sharedURL: url)
                        } else {
                            self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
                        }
                    }
                    return
                }
            }
        }
    }
    
    private func sendToBackend(sharedURL: URL) {
        guard let accessToken = SharedKeyChain.shared.string(forKey: "accessToken") else {
            print("액세스 토큰 없음")
            self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
            return
        }
        
        let parameters: [String: Any] = ["url": sharedURL.absoluteString]
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
        
        // URL 전송 요청
        AF.request("http://localhost/links",
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers
        )
        .validate()
        .responseDecodable(of: LinkResponse.self) { [weak self] response in
            switch response.result {
            case .success(let linkResponse):
                print("URL 저장 성공: \(linkResponse)")
                self?.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
                
            case .failure(let error):
                if let httpResponse = response.response, httpResponse.statusCode == 401 {
                    print("액세스 토큰 만료, 리프레시 토큰으로 갱신 시도")
                    self?.refreshTokenAndRetry(sharedURL: sharedURL)
                } else {
                    print("URL 저장 실패: \(error)")
                    self?.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
                }
            }
        }
    }
    
    private func refreshTokenAndRetry(sharedURL: URL) {
        guard let refreshToken = SharedKeyChain.shared.string(forKey: "refreshToken") else {
            print("리프레시 토큰 없음")
            self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(refreshToken)"]
        
        AF.request("http://localhost/auth/refresh",
                   method: .get,
                   headers: headers
        )
        .validate()
        .responseDecodable(of: RefreshTokenResponse.self) { [weak self] response in
            switch response.result {
            case .success(let tokenResponse):
                print("새로운 액세스 토큰 발급 성공: \(tokenResponse.accessToken)")
                SharedKeyChain.shared.set(tokenResponse.accessToken, forKey: "accessToken")
                
                self?.sendToBackend(sharedURL: sharedURL)
                
            case .failure(let error):
                print("리프레시 토큰 요청 실패: \(error)")
                self?.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
            }
        }
    }
    
    override func configurationItems() -> [Any]! {
        return []
    }
}
