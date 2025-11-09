//
//  ContentView.swift
//  Swift_Test
//
//  Created by 花井悠真 on 2025/11/01.
//

import SwiftUI

struct ContentView: View {
    @State private var SearchText: String = ""
    var body: some View {
        NavigationStack {
            Content()
        }
        .searchable(text: $SearchText)
    }
}


struct Content: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("なんでも可能")
        }
        .padding()
    }
}

struct Content2: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("なんでも可能2")
        }
        .padding()
    }
}

struct ToolBarView: View {
    @Namespace private var animation
    @State private var showMenu: Bool = false
    var body: some View {
        NavigationStack {
            List{
                Text("なんでも可能")
            }
            .navigationTitle("This is title") // メインタイトル
            .navigationSubtitle("This is subtitle") // サブタイトル
            
            // toolbar
            .toolbar {
                // topBarTrailing ヘッダー部分に配置
                ToolbarItem(placement:.topBarTrailing){
                    Button("Notification" , systemImage: "bell"){}
                }
//                .sharedBackgroundVisibility(.hidden) // 背景を見せたり隠したりする
                
                ToolbarItem{
                    Button("Account" , systemImage: "person"){
                        showMenu.toggle()
                    }
                }
                .matchedTransitionSource(id: "Account", in: animation)
                
                // bottomBar 画面下部に配置
                ToolbarItem(placement:.bottomBar){
                    Button("share" , systemImage: "square.and.arrow.up"){}
                }
                
                ToolbarItem(placement:.bottomBar){
                    Button("clipboard" , systemImage: "document.on.clipboard"){}
                }
            }
            .sheet(isPresented: $showMenu){
                Text("Account Sheet")
                    .navigationTransition(.zoom(sourceID: "Account" , in : animation))
            }
        }
    }
}

