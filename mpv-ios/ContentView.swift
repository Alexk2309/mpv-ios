//
//  ContentView.swift
//  mpv-ios
//
//  Created by Alex Kim on 27/2/2026.
//

import SwiftUI

struct ContentView: View {
    private let testURL = URL(string: "https://github.com/mpvkit/video-test/raw/master/resources/h265.mp4")!

    @State private var isPlayerPresented = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            Button {
                isPlayerPresented = true
            } label: {
                VStack(spacing: 12) {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 72))
                        .foregroundStyle(.white)
                    Text("Play Test Video")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
            }
        }
        .fullScreenCover(isPresented: $isPlayerPresented) {
            iOSPlayerScreen(url: testURL)
        }
    }
}

#Preview {
    ContentView()
}
