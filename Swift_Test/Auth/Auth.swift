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
    @State private var Isloading: Bool = false // ログインボタンを押下されたかの判定
    
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
                try? await Task.sleep(for : .seconds(5)) // 非同期タスク内で、キャンセルされるかもしれない5秒待機を、例外無視で行う
            } onStatusChange : { isLogin in
                Isloading = isLogin // ログイン状態をIsloading に渡している
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
        .allowsTightening(!Isloading) // テキストの文字間を詰めてもよいかを指定するモディファイア
        .opacity(Isloading ? 0.8 : 1) //もし isLoading が true なら 0.8、そうでなければ 1.0 を返す (? は if 分の役割 )
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
                .opacity(isLogin ? 0 : 1) // Title の文言を不透明にする (見えなくする)
                // ボタンの上にローディング表示をふわっと重ねて出す
                .overlay(
                    ProgressView()
                        .opacity(isLogin ? 1 : 0)
                )
                .padding(.vertical, 10)
        }
        .buttonStyle(.borderedProminent)
        .animation(.easeInOut(duration: 0.1) , value: isLogin ) // isLogin が変わったときに、UI更新を0.25秒でアニメーションさせる
        .buttonBorderShape(.capsule)
        .tint(Color.primary)
        .disabled(isLogin) // 引数のBool値が true のとき、そのViewを操作不能にする修飾子
        // ログイン状態（isLogin）が変わったら、その新しい状態を外部（親Viewなど）に通知する
        .onChange(of: isLogin) { oldValue, newValue in
            onStatusChange(newValue)
        }
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
