//
//  LoginViewModel.swift
//  Linky
//
//  Created by 박성민 on 3/20/25.
//

import Foundation
import Combine
import SwiftKeychainWrapper

class LoginViewModel: ObservableObject{
    enum Action{
        case login
        case goLogin
        case goSignUp
    }
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String? = nil
    
    private var container: DIContainer
    private var pathModel : RootViewModel
    private var subscriber = Set<AnyCancellable>()
    
    init(container: DIContainer, pathModel: RootViewModel){
        self.container = container
        self.pathModel = pathModel
    }
    
    func send(action: Action){
        switch action {
        case .login:
            login { _ in }
        case .goLogin:
            self.pathModel.send(action: .push(.main))
        case .goSignUp:
            print("회원가입으로")
            self.pathModel.send(action: .push(.signUp))
        }
    }
    
    func login(completion : @escaping (Bool) -> Void){
        print("로그인")
        let request = LoginRequest(
            email: email,
            password: password
        )
        container.services.authService.login(request: request)
            .sink { [weak self] completionResult in
                switch completionResult{
                case .finished:
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        switch error {
                        case .apiError(let response):
                            self?.errorMessage = response.message.values.joined(separator: "\n")
                            
                        case .decodingError(let message):
                            self?.errorMessage = "데이터 처리 중 오류가 발생했습니다: \(message)"
                            
                        case .networkError(let message):
                            self?.errorMessage = "인터넷 연결을 확인해 주세요: \(message)"
                            
                        case .unknown(let message):
                            self?.errorMessage = "알 수 없는 오류: \(message)"
                        }
                        completion(false)
                    }
                }
            } receiveValue: { response in
                DispatchQueue.main.async {
                    print("로그인 성공")
                    // ShareExtension용 keyChain
                    SharedKeyChain.shared.set(response.accessToken, forKey: "accessToken")
                    SharedKeyChain.shared.set(response.refreshToken, forKey: "refreshToken")
                    
                    KeychainWrapper.standard.set(response.accessToken, forKey: "accessToken")
                    KeychainWrapper.standard.set(response.refreshToken, forKey: "refreshToken")
                    print(KeychainWrapper.standard.string(forKey: "accessToken") ?? "없슴")
                    print("리프레시토큰\(KeychainWrapper.standard.string(forKey: "refreshToken") ?? "없음")")
                    self.errorMessage = nil
                    completion(true)
                }
            }
            .store(in: &subscriber)
    }
}
