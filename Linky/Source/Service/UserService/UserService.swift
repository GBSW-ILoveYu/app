//
//  UserService.swift
//  Linky
//
//  Created by 박성민 on 5/10/25.
//

import Foundation
import Alamofire
import Combine
import SwiftKeychainWrapper

class CancellableStore {
    static let shared = CancellableStore()
    var set: Set<AnyCancellable> = []
}

protocol UserServiceType {
    func getUser() -> AnyPublisher<User, UserError>
    func refreshToken() -> AnyPublisher<TokenResponse, UserError>
}

class UserService : UserServiceType {
    private let url = "\(APIConstants.url)/auth"
    private var isRefreshing = false
    
    func getUser() -> AnyPublisher<User, UserError> {
        guard let accessToken = KeychainWrapper.standard.string(forKey: "accessToken") else {
            return Fail(error: UserError.noToken).eraseToAnyPublisher()
        }
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(accessToken)"
        ]
//        print(headers)
        return Future<User,UserError> { promise in
            AF.request("\(self.url)/me",
                       method: .get,
                       headers: headers)
            .validate()
            .responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let user):
                    promise(.success(user))
                case .failure:
                    if response.response?.statusCode == 401{
                        self.refreshToken()
                            .flatMap { _ in self.getUser() }
                            .sink { completion in
                                if case .failure(let error) = completion {
                                    promise(.failure(error))
                                }
                            } receiveValue: { user in
                                promise(.success(user))
                            }
                            .store(in: &CancellableStore.shared.set)
                    } else if let data = response.data, let errorResponse = try? JSONDecoder().decode(UserErrorResponse.self, from: data) {
                        promise(.failure(.serverError(errorResponse)))
                    } else {
                        promise(.failure(.networkError("유저를 가져오는데 실패했습니다: \(response.error?.localizedDescription ?? "유저가 없음")")))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func refreshToken() -> AnyPublisher<TokenResponse, UserError>{
        guard !isRefreshing else {
            return Fail(error: UserError.refreshInProgress).eraseToAnyPublisher()
        }
        guard let refreshToken = KeychainWrapper.standard.string(forKey: "refreshToken") else {
            return Fail(error: UserError.noToken).eraseToAnyPublisher()
        }
        
        isRefreshing = true
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(refreshToken)"
        ]
        
        return Future { promise in
            AF.request("\(self.url)/refresh",
                       method: .get,
                       headers: headers)
            .validate()
            .responseDecodable(of: TokenResponse.self) { response in
                defer { self.isRefreshing = false}
                switch response.result {
                case .success(let tokenResponse):
                    KeychainWrapper.standard.set(tokenResponse.accessToken, forKey: "accessToken")
                    KeychainWrapper.standard.set(tokenResponse.refreshToken, forKey: "refreshToken")
                    promise(.success(tokenResponse))
                case .failure:
                    if let data = response.data,
                       let errorResponse = try? JSONDecoder().decode(UserErrorResponse.self, from: data) {
                        promise(.failure(.serverError(errorResponse)))
                    } else {
                        promise(.failure(.networkError("Failed to refresh token: \(response.error?.localizedDescription ?? "Unknown error")")))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

class StubUserService : UserServiceType{
    func getUser() -> AnyPublisher<User, UserError> {
        Empty().eraseToAnyPublisher()
    }
    
    func refreshToken() -> AnyPublisher<TokenResponse, UserError>{
        Empty().eraseToAnyPublisher()
    }
}
