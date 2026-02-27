import SwiftUI
import AVFoundation
import UIKit

// MARK: - UIView hosting the AVSampleBufferDisplayLayer + MPVLayerRenderer

final class MPVHostView: UIView {
    let displayLayer = AVSampleBufferDisplayLayer()
    private var renderer: MPVLayerRenderer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        displayLayer.videoGravity = .resizeAspect
        layer.addSublayer(displayLayer)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        displayLayer.frame = bounds
    }

    func startPlayback(url: URL) {
        let r = MPVLayerRenderer(displayLayer: displayLayer)
        self.renderer = r
        do {
            try r.start()
            let preset = PlayerPreset(
                id: .sdrRec709,
                title: "Default",
                summary: "",
                stream: nil,
                commands: []
            )
            r.load(url: url, with: preset)
        } catch {
            print("[iOSPlayerView] Failed to start renderer: \(error)")
        }
    }

    func stopPlayback() {
        renderer?.stop()
        renderer = nil
    }
}

// MARK: - UIViewRepresentable bridge for SwiftUI

struct iOSPlayerView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> MPVHostView {
        let view = MPVHostView()
        view.startPlayback(url: url)
        return view
    }

    func updateUIView(_ uiView: MPVHostView, context: Context) {}

    static func dismantleUIView(_ uiView: MPVHostView, coordinator: ()) {
        uiView.stopPlayback()
    }
}

// MARK: - Full-screen player screen

struct iOSPlayerScreen: View {
    let url: URL
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.black.ignoresSafeArea()

            iOSPlayerView(url: url)
                .ignoresSafeArea()

            // Close button
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 28))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.white)
                    .padding(16)
            }
        }
    }
}
