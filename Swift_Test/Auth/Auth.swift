//
//  Auto.swift
//  Swift_Test
//
//  Created by 花井悠真 on 2025/11/06.
//

import Foundation
import SwiftUI

// 11/07 23:00 次回は、Sign In のアクティブ・非アクティブについてまとめる

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack(alignment:.leading , spacing: 10){
            VStack(alignment:.leading , spacing: 8){
                Text("ログインページです")
                    .font(.largeTitle)
                Text("ログインフォームを表示します")
                    .font(.callout)
            }
            .fontWeight(.medium)
            .padding(10)
            
            CustomTextField(hint:"Eメール アドレス" , symbol : "mail" , value : $email)
                .padding(.top, 10)
                .padding(.horizontal,10)
            
            CustomTextField(hint:"パスワード" , symbol : "key" ,  isPassword: true , value : $password)
                .padding(.top, 10)
                .padding(.horizontal,10)
            
            // パスワードを忘れた際のボタンを記載
            Button("パスワードを忘れましたか？") {
                //content
            }
            .tint(.primary)
            .frame(maxWidth: .infinity , alignment: .trailing)
            .padding(.top , 10)
            .padding(.horizontal , 10)
            
            // Sign In ボタン
            SignInView(title: "Sign In"){
                // content
            } onStatusChange : { isLogin in
                // content
            }
            .padding(.top, 20)
            .padding(.horizontal , 10)
            .disabled(!isSignInButtonEnabled) // メアド・パスワードが入力されていないとアクティブにしない
            
            HStack{
                Text("アカウントをお持ちではないですか？")
                Button{
                    
                } label: {
                    Text("Sign Up")
                        .underline()
                }
            }
            .fontWeight(.medium)
            .padding(.top, 10)
            .foregroundStyle(Color.primary)
            .frame(maxWidth: .infinity)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity , alignment: .topLeading)
        .padding(.top, 20)
    }
    
    // メアド・パスワードが入力されていなかった場合は Sign In ボタンをアクティブにしない
    var isSignInButtonEnabled: Bool {
        !email.isEmpty && !password.isEmpty // only empty
//        !email.isEmpty && password.count >= 8 // パスワードの文字列が8文字以上
    }
}

struct SignInView: View {
    var title : String
    var onTask : () async -> () // 非同期で実行する処理を外から注入できるトリガー用の変数
    var onStatusChange: (Bool) -> () = { _ in } // 実行しているかどうかの判定
    @State private var isLogin: Bool = false
    var body: some View {
        Button {
            Task{
                isLogin = true
                await onTask()
                // 若干のスリープ処理
                try? await Task.sleep(for: .seconds(0.1))
                
                isLogin = false
            }
        } label: {
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .tint(Color.primary)
        .disabled(isLogin) // 引数のBool値が true のとき、そのViewを操作不能にする修飾子
    }
}


// 入力の欄
struct CustomTextField: View {
    var hint: String
    var symbol: String
    var isPassword: Bool = false
    @Binding var value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: symbol)
                .font(.callout)
                .foregroundStyle(.gray)
                .frame(width: 30)
            
            Group {
                if isPassword {
                    SecureField(hint, text: $value) // ⚫️ 表示になる
                } else {
                    TextField(hint, text: $value)
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
        .clipShape(.capsule)
    }
}

#Preview {
    LoginView()
}
