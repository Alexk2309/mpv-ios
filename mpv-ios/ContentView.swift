//
//  ContentView.swift
//  mpv-ios
//
//  Created by Alex Kim on 27/2/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
#if compiler(>=6.0)
        if #available(iOS 26.0, *) {
            TabView {
                Tab("Home", systemImage: "house.fill") {
                    HomeView()
                }
                Tab("Settings", systemImage: "gear") {
                    SettingsView()
                }
            }
            .tabBarMinimizeBehavior(.onScrollDown)
            .accentColor(Color("AccentColor"))
        } else {
            olderTabView
        }
#else
        olderTabView
#endif
    }

    private var olderTabView: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .accentColor(Color("AccentColor"))
    }
}

#Preview {
    ContentView()
}
