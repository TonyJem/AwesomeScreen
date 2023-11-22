import SwiftUI

public struct LoadingIndicator: View {

    @State private var isLoading = false
    @State private var degree: Double = 270
    @State private var spinnerLength = 0.6

    private let config: Configuration

    init(
        isLoading: Bool = false,
        config: Configuration = Configuration(
            width: 44,
            height: 44,
            strokeWidth: 2,
            strokeColor: Color(.Branded.foregroundHighlight))
    ) {
        self.isLoading = isLoading
        self.config = config
    }

    public var body: some View {
        Circle()
            .trim(from: 0, to: spinnerLength)
            .stroke(
                config.strokeColor,
                style: StrokeStyle(
                    lineWidth: config.strokeWidth,
                    lineCap: .round,
                    lineJoin: .round
                )
            )
            .animation(
                Animation
                    .easeIn(duration: 1.125)
                    .repeatForever(autoreverses: true))
            .frame(
                width: config.width,
                height: config.height
            )
            .rotationEffect(
                Angle(degrees: degree)
            )
            .animation(
                Animation
                    .linear(duration: 0.75)
                    .repeatForever(autoreverses: false))
            .onAppear {
                self.isLoading = true
                degree = 270 + 360
                spinnerLength = 0
            }
    }

}

extension LoadingIndicator {

    public struct Configuration {

        let width: CGFloat
        let height: CGFloat
        let strokeWidth: CGFloat
        let strokeColor: Color

    }

}
