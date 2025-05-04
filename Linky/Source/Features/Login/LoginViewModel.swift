//
//  LoginViewModel.swift
//  Linky
//
//  Created by 박성민 on 3/20/25.
//

import Foundation

class LoginViewModel: ObservableObject{
    @Published var id: String = ""
    @Published var password: String = ""
    
    private var container: DIContainer
    
    init(container: DIContainer){
        self.container = container
    }
    
    func login(){
        print("로그인!")
    }
    
    func signUp(){
        print("회원가입!")
    }
}
