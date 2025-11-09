//
//  search.swift
//  Swift_Test
//
//  Created by 花井悠真 on 2025/11/05.
//

import Foundation
import SwiftUI


struct FruitListView: View {
    @State private var searchText = ""
    let fruits = ["Apple", "Banana", "Cherry", "Mango", "Peach"]

    var filteredFruits: [String] {
        if searchText.isEmpty {
            return fruits
        } else {
            return fruits.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredFruits, id: \.self) { fruit in
                Text(fruit)
            }
//            .searchable(text: $searchText, prompt: "フルーツを検索")
            .navigationTitle("フルーツ一覧")
        }
    }
}

struct TestSearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack{
            Text("Hello, World!")
            
                .searchable(text: $searchText, prompt: "検索")
        }
    }
}

struct TestTabSearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        TabView{
            Tab("Tab1", systemImage: "figure") {
                //pass
            }
            Tab("Tab2", systemImage: "figure.mind.and.body") {
                //pass
            }
            Tab("Tab3", systemImage: "figure.run") {
                //pass
            }
            Tab(role: .search) {
                NavigationStack{
                    Text("Hello, World!")
                    
                        .searchable(text: $searchText, prompt: "検索")
                }
            }
        }
    }
}

