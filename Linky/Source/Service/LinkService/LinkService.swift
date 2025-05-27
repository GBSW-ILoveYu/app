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
    func getLink() -> AnyPublisher<[LinkResponse],LinkError>
    func detailgetLink(categoryTitle: String) -> AnyPublisher<[LinkResponse],LinkError>
    func sendLink(url: String) -> AnyPublisher<String,LinkError>
    func getLinkCount() -> AnyPublisher<Void,LinkError>
}

class LinkService: LinkServiceType {
    func getLink() -> AnyPublisher<[LinkResponse],LinkError>{
        let baseURL = APIConstants.linkURL
        
        let token = KeychainWrapper.standard.string(forKey: "accessToken") ?? "없음"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        return Future<[LinkResponse],LinkError> { promise in
            AF.request(baseURL,
                       method: .get,
                       headers: headers)
            .responseDecodable(of: [LinkResponse].self) { response in
                switch response.result {
                case .success(let value):
                    promise(.success(value))
                case .failure:
                    promise(.failure(LinkError.networkError))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func detailgetLink(categoryTitle: String) -> AnyPublisher<[LinkResponse],LinkError>{
        let baseURL = APIConstants.linkURL
        
        let token = KeychainWrapper.standard.string(forKey: "accessToken") ?? "없음"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        var parameter: Parameters = [:]
        parameter["category"] = categoryTitle
        
        return Future<[LinkResponse],LinkError> { promise in
            AF.request(baseURL,
                       method: .get,
                       parameters: parameter,
                       headers: headers)
            .validate()
            .responseDecodable(of:[LinkResponse].self){ response in
                switch response.result{
                case .success(let value):
                    promise(.success(value))
                case .failure(let error):
                    promise(.failure(LinkError.networkError))
                }
            }
        }.eraseToAnyPublisher()
    }
    
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
                        let decoded = try JSONDecoder().decode(LinkResponse.self, from: data)
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
    func getLink() -> AnyPublisher<[LinkResponse],LinkError>{
        Empty().eraseToAnyPublisher()
    }
    
    func detailgetLink(categoryTitle: String) -> AnyPublisher<[LinkResponse],LinkError>{
        Empty().eraseToAnyPublisher()
    }
    
    func sendLink(url : String)  -> AnyPublisher<String,LinkError>{
        Empty().eraseToAnyPublisher()
    }
    
    func getLinkCount() -> AnyPublisher<Void,LinkError> {
        Empty().eraseToAnyPublisher()
    }
}
