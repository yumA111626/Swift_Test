//
//  Toolbar.swift
//  Swift_Test
//
//  Created by 花井悠真 on 2025/11/06.
//

import SwiftUI


struct ToolBarTestView: View {
    var body: some View {
        NavigationStack {
            VStack{
                // content
            }
            .toolbar {
                // topBarTrailing ヘッダー部分に配置
                ToolbarItem(placement:.topBarTrailing){
                    Button("Notification" , systemImage: "bell"){}
                }
                // bottomBar 画面下部に配置
                ToolbarItem(placement:.bottomBar){
                    Button("share" , systemImage: "square.and.arrow.up"){}
                }
                ToolbarItem(placement:.bottomBar){
                    Button("clipboard" , systemImage: "document.on.clipboard"){}
                }
            }
            
        }
    }
}
