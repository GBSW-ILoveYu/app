//
//  LinkService.swift
//  Linky
//
//  Created by 박성민 on 5/12/25.
//

import Foundation
import Combine
import SwiftKeychainWrapper
import Alamofire

protocol LinkServiceType {
    func sendLink(url: String) -> AnyPublisher<String,LinkError>
    func getLinkCount() -> AnyPublisher<Void,LinkError>
}

class LinkService: LinkServiceType {
    func sendLink(url : String)  -> AnyPublisher<String,LinkError>{
        let baseURL = APIConstants.linkURL
        
        let parameters = [
            "url" : url
        ]
        
        let token = KeychainWrapper.standard.string(forKey: "accessToken") ?? "없음"
        print("Access Token: \(token)")
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        return Future<String,LinkError>{ promise in
            AF.request(baseURL,
                       method: .post,
                       parameters: parameters,
                       encoder: JSONParameterEncoder.default,
                       headers: headers)
            .validate()
            .responseData{ response in
                switch response.result{
                case .success(let data):
                    do{
                        let decoded = try JSONDecoder().decode(sendLinkResponse.self, from: data)
                        print(decoded)
                        let category = decoded.category
                        promise(.success(category))
                    } catch {
                        print("응답 디코딩 실패")
                        promise(.failure(LinkError.decodingError))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    if error.responseCode == 400{
                        promise(.failure(LinkError.missingUrlError))
                    } else {
                        promise(.failure(LinkError.networkError))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getLinkCount() -> AnyPublisher<Void,LinkError> {
        Empty().eraseToAnyPublisher()
    }
}

class StubLinkService: LinkServiceType{
    func sendLink(url : String)  -> AnyPublisher<String,LinkError>{
        Empty().eraseToAnyPublisher()
    }
    
    func getLinkCount() -> AnyPublisher<Void,LinkError> {
        Empty().eraseToAnyPublisher()
    }
}
