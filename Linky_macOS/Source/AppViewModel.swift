//
//  AppViewModel.swift
//  Linky_macOS
//
//  Created by 박성민 on 6/18/25.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class AppViewModel: ObservableObject{
    enum Action {
        case login
        case signup
        case addLink
    }
    
    @Published var currentView: ViewPath = .login
    @Published var login: Login = Login(email: "", password: "")
    @Published var signUp: SignUp = SignUp(name: "", id: "", password: "", passwordCheck: "", email: "")
    @Published var sendUrl: String = ""
    let url = "http://localhost"
    
    var dynamicHeight: CGFloat {
        switch currentView {
        case .main:
            return 228
        case .login:
            return 380
        case .signup:
            return 600
        }
    }
    
    func send(action: Action){
        switch action {
        case .login:
            let parameter: [String: Any] = [
                "email": login.email,
                "password": login.password
            ]
            
            AF.request("\(url)/auth/signin",
                       method: .post,
                       parameters: parameter,
                       encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: LoginSuccessResponse.self) { response in
                switch response.result{
                case .success(let value):
                    KeychainWrapper.standard.set(value.accessToken, forKey: "accessToken")
                    KeychainWrapper.standard.set(value.refreshToken, forKey: "refreshToken")
                    self.currentView = .main
                case .failure(let error):
                    print(error)
                }
            }
        case .signup:
            if signUp.password != signUp.passwordCheck{
                print("password와 passwordCheck가 일치하지 않습니다")
                return
            }
            
            let parameter: [String: Any] = [
                "email": signUp.email,
                "password": signUp.password,
                "nickName": signUp.name,
                "userId": signUp.id
            ]
            AF.request("\(url)/auth/signup",
                       method: .post,
                       parameters: parameter,
                       encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: SignUpSuccessResponse.self){ response in
                switch response.result{
                case .success(let value):
                    print(value)
                    self.currentView = .login
                case .failure(let error):
                    print(error)
                }
            }
        case .addLink:
            guard let token = KeychainWrapper.standard.string(forKey: "accessToken") else {
                print("토큰이 없습니다")
                return
            }
            
            let parameter: [String: Any] = [
                "url": sendUrl
            ]
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)"
            ]
            AF.request("\(url)/links",
                       method: .post,
                       parameters: parameter,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .validate()
            .response{ response in
                switch response.result{
                case .success:
                    self.sendUrl = ""
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
