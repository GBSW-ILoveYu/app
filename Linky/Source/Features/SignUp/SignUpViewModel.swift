//
//  SignUpViewModel.swift
//  Linky
//
//  Created by 박성민 on 3/20/25.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var id: String = ""
    @Published var password: String = ""
    @Published var passwordCheck: String = ""
    @Published var email: String = ""
    
    @Published var errorMessage: String? = nil
    @Published var errorBox: Set<SignUpField> = []
    
    private var container: DIContainer
    private var subscriber = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func signUp(completion: @escaping (Bool) -> Void) {
        if password != passwordCheck {
            errorMessage = "비밀번호가 일치하지 않습니다."
            errorBox.insert(.passwordCheck)
            completion(false)
            return
        }
        
        let request = SignUpRequest(
            email: email,
            password: password,
            nickName: name,
            userId: id
        )
        
        container.services.authService.signUp(request: request)
            .sink { [weak self] completionResult in
                switch completionResult {
                case .finished:
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        switch error {
                        case .apiError(let response):
                            self?.errorMessage = response.message.values.joined(separator: "\n")
                            
                            var errorFields: Set<SignUpField> = []
                            let messages = response.message.values
                            for message in messages {
                                if message.contains("nickName") {
                                    errorFields.insert(.name)
                                }
                                if message.contains("userId") {
                                    errorFields.insert(.id)
                                }
                                if message.contains("password") {
                                    errorFields.insert(.password)
                                }
                                if message.contains("email") || message.contains("이메일") {
                                    errorFields.insert(.email)
                                }
                            }
                            self?.errorBox = errorFields
                            
                        case .decodingError(let message):
                            self?.errorMessage = "데이터 처리 중 오류가 발생했습니다: \(message)"
                            self?.errorBox = []
                            
                        case .networkError(let message):
                            self?.errorMessage = "네트워크 연결에 문제가 있습니다: \(message)"
                            self?.errorBox = []
                            
                        case .unknown(let message):
                            self?.errorMessage = "알 수 없는 오류: \(message)"
                            self?.errorBox = []
                        }
                        completion(false)
                    }
                }
            } receiveValue: { response in
                DispatchQueue.main.async {
                    print("회원가입 성공: \(response)")
                    self.errorMessage = nil
                    self.errorBox = []
                    completion(true)
                }
            }
            .store(in: &subscriber)
    }
}
