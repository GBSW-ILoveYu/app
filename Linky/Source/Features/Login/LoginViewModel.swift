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
            login { success in
                if success {
                    self.pathModel.send(action: .push(.main))
                }
            }
        case .goSignUp:
            print("회원가입으로")
            self.pathModel.send(action: .push(.signUp))
        }
    }
    
    func login(completion : @escaping (Bool) -> Void){
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
                    DispatchQueue.main.async{
                        self?.errorMessage = error.message.values.joined(separator: "\n")
                        completion(false)
                    }
                }
            } receiveValue: { response in
                DispatchQueue.main.async {
                    print("로그인 성공")
                    KeychainWrapper.standard.set(response.accessToken, forKey: "accessToken")
                    KeychainWrapper.standard.set(response.refreshToken, forKey: "refreshToken")
                    completion(true)
                }
            }
            .store(in: &subscriber)
    }
}
