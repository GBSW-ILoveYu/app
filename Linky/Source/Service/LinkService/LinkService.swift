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
    func recentlyOpened() -> AnyPublisher<[LinkResponse],LinkError>
    func detailGetLink(id: Int) -> AnyPublisher<LinkResponse,LinkError>
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
                case .failure:
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
                        if let data = response.data{
                            do{
                                let errorResponse = try JSONDecoder().decode(LinkErrorResponse.self,from: data)
                                let message = errorResponse.message
                                promise(.failure(.urlError(message: message)))
                            }catch{
                                promise(.failure(.urlError(message: .one("알 수 없는 에러"))))
                            }
                        }
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
    
    func recentlyOpened() -> AnyPublisher<[LinkResponse],LinkError> {
        let baseURL = APIConstants.linkURL
        
        let token = KeychainWrapper.standard.string(forKey: "accessToken") ?? "없음"
        print("Access Token: \(token)")
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        return Future<[LinkResponse],LinkError> { promise in
            AF.request("\(baseURL)/recently-opened",
                       method: .get,
                       encoding: URLEncoding.default,
                       headers: headers)
            .validate()
            .responseDecodable(of: [LinkResponse].self){ response in
                switch response.result{
                case .success(let value):
                    print(value)
                    promise(.success(value))
                case .failure:
                    promise(.failure(LinkError.networkError))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func detailGetLink(id: Int) -> AnyPublisher<LinkResponse,LinkError>{
        let baseURL = APIConstants.linkURL
        
        let token = KeychainWrapper.standard.string(forKey: "accessToken") ?? "없음"
        print("Access Token: \(token)")
        
        let parameters: [String: Any] = [
            "id": id
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        return Future<LinkResponse,LinkError> { promise in
            AF.request("\(baseURL)/\(id)",
                       method: .get,
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: headers)
            .validate()
            .responseDecodable(of: LinkResponse.self){ response in
                switch response.result{
                case .success(let value):
                    promise(.success(value))
                case .failure:
                    promise(.failure(LinkError.networkError))
                }
            }
        }.eraseToAnyPublisher()
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
    
    func recentlyOpened() -> AnyPublisher<[LinkResponse],LinkError> {
        Empty().eraseToAnyPublisher()
    }
    
    func detailGetLink(id: Int) -> AnyPublisher<LinkResponse,LinkError>{
        Empty().eraseToAnyPublisher()
    }
}
