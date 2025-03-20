//
//  SignUpViewModel.swift
//  Linky
//
//  Created by 박성민 on 3/20/25.
//

import Foundation

class SignUpViewModel: ObservableObject{
    @Published var name: String = ""
    @Published var id : String = ""
    @Published var password: String = ""
    @Published var passwordCheck: String = ""
    @Published var email: String = ""
    @Published var errorMessage: String? = nil
    @Published var errorBox: Int = 0
    func signUp() -> Bool {
        if password != passwordCheck {
            errorMessage = "비밀번호가 일치하지 않습니다."
            errorBox = 4
            return false
        }
        errorMessage = nil
        return true
    }
}
