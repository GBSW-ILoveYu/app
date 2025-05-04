//
//  LoginViewModel.swift
//  Linky
//
//  Created by 박성민 on 3/20/25.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject{
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var errorMessage: String? = nil
    
    private var container: DIContainer
    private var subscriber = Set<AnyCancellable>()
    
    init(container: DIContainer){
        self.container = container
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
                    //TODO: switKeyChain저장로직 추가
                    completion(true)
                }
            }
            .store(in: &subscriber)
    }
    
    func signUp(){
        print("회원가입!")
    }
}
