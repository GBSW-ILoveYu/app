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

class AuthService: AuthServiceType {
    func signUp(request: SignUpRequest) -> AnyPublisher<SignUpSuccessResponse, AuthError> {
        let url = APIConstants.signUpURL
        
        return Future<SignUpSuccessResponse, AuthError> { promise in
            AF.request(url,
                       method: .post,
                       parameters: request,
                       encoder: JSONParameterEncoder.default)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoded = try JSONDecoder().decode(SignUpSuccessResponse.self, from: data)
                        promise(.success(decoded))
                    } catch {
                        promise(.failure(.decodingError("응답 디코딩 실패: \(error.localizedDescription)")))
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let errorResponse = try JSONDecoder().decode(AuthErrorResponse.self, from: data)
                            promise(.failure(.apiError(errorResponse)))
                        } catch {
                            promise(.failure(.decodingError("에러 응답 디코딩 실패: \(error.localizedDescription)")))
                        }
                    } else {
                        promise(.failure(.networkError("알 수 없는 네트워크 에러")))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func login(request: LoginRequest) -> AnyPublisher<LoginSuccessResponse, AuthError> {
        let url = APIConstants.loginURL
        
        return Future<LoginSuccessResponse, AuthError> { promise in
            AF.request(url,
                       method: .post,
                       parameters: request,
                       encoder: JSONParameterEncoder.default)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoded = try JSONDecoder().decode(LoginSuccessResponse.self, from: data)
                        promise(.success(decoded))
                    } catch {
                        promise(.failure(.decodingError("응답 디코딩 실패: \(error.localizedDescription)")))
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let errorResponse = try JSONDecoder().decode(AuthErrorResponse.self, from: data)
                            promise(.failure(.apiError(errorResponse)))
                        } catch {
                            promise(.failure(.decodingError("에러 응답 디코딩 실패: \(error.localizedDescription)")))
                        }
                    } else {
                        promise(.failure(.networkError("알 수 없는 네트워크 에러")))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

class StubAuthService: AuthServiceType {
    func signUp(request: SignUpRequest) -> AnyPublisher<SignUpSuccessResponse, AuthError> {
        Empty().eraseToAnyPublisher()
    }
    
    func login(request: LoginRequest) -> AnyPublisher<LoginSuccessResponse, AuthError> {
        Empty().eraseToAnyPublisher()
    }
}
