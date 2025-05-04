//
//  authService.swift
//  Linky
//
//  Created by 박성민 on 5/1/25.
//

import Foundation
import Combine
import Alamofire

protocol AuthServiceType {
    func signUp(request: SignUpRequest) -> AnyPublisher<SignUpSuccessResponse,AuthError>
    func login(request: LoginRequest) -> AnyPublisher<LoginSuccessResponse,AuthError>
}

class AuthService : AuthServiceType {
    func signUp(request: SignUpRequest) -> AnyPublisher<SignUpSuccessResponse,AuthError>{
        let url = APIConstants.signUpURL
        
        return Future<SignUpSuccessResponse,AuthError> { promise in
            AF.request(url,
                       method: .post,
                       parameters: request,
                       encoder: JSONParameterEncoder.default)
            .validate()
            .responseData{ response in
                switch response.result {
                case .success(let data):
                    do{
                        let decoded = try JSONDecoder().decode(SignUpSuccessResponse.self, from: data)
                        promise(.success(decoded))
                    } catch {
                        promise(.failure(AuthError(
                            message: OneOrMany.many(["응답 디코딩 실패: \(error.localizedDescription)"]),
                            error: "Decoding Error",
                            statusCode: response.response?.statusCode ?? -1
                        )))
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let errorResponse = try JSONDecoder().decode(AuthError.self, from: data)
                            promise(.failure(errorResponse))
                        } catch {
                            promise(.failure(AuthError(
                                message: OneOrMany.many(["응답 디코딩 실패: \(error.localizedDescription)"]),
                                error: "Unknown Error",
                                statusCode: response.response?.statusCode ?? -1
                            )))
                        }
                    } else {
                        promise(.failure(AuthError(
                            message: OneOrMany.many(["알 수 없는 네트워크 에러"]),
                            error: "Network Error",
                            statusCode: response.response?.statusCode ?? -1
                        )))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func login(request: LoginRequest) -> AnyPublisher<LoginSuccessResponse,AuthError>{
        let url = APIConstants.loginURL
        
        return Future<LoginSuccessResponse,AuthError> { promise in
            AF.request(url,
                       method: .post,
                       parameters: request,
                       encoder: JSONParameterEncoder.default)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do{
                        let decoded = try JSONDecoder().decode(LoginSuccessResponse.self, from: data)
                        promise(.success(decoded))
                    } catch {
                        promise(.failure(AuthError(
                            message: OneOrMany.many(["응답 디코딩 실패: \(error.localizedDescription)"]),
                            error: "Decoding Error",
                            statusCode: response.response?.statusCode ?? -1
                        )))
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let errorResponse = try JSONDecoder().decode(AuthError.self, from: data)
                            promise(.failure(errorResponse))
                        } catch {
                            promise(.failure(AuthError(
                                message: OneOrMany.many(["응답 디코딩 실패: \(error.localizedDescription)"]),
                                error: "Unknown Error",
                                statusCode: response.response?.statusCode ?? -1
                            )))
                        }
                    } else {
                        promise(.failure(AuthError(
                            message: OneOrMany.many(["알 수 없는 네트워크 에러"]),
                            error: "Network Error",
                            statusCode: response.response?.statusCode ?? -1
                        )))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

class StubAuthService : AuthServiceType {
    func signUp(request: SignUpRequest) -> AnyPublisher<SignUpSuccessResponse,AuthError>{
        Empty().eraseToAnyPublisher()
    }
    
    func login(request: LoginRequest) -> AnyPublisher<LoginSuccessResponse,AuthError>{
        Empty().eraseToAnyPublisher()
    }
}
