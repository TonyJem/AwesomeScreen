import SwiftUI

public struct LoadingIndicator: View {

    @State private var isLoading = false

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
            .trim(from: 0, to: 0.60)
            .stroke(
                config.strokeColor,
                style: StrokeStyle(
                    lineWidth: config.strokeWidth,
                    lineCap: .round,
                    lineJoin: .round
                )
            )
            .frame(
                width: config.width,
                height: config.height
            )
            .rotationEffect(
                Angle(degrees: isLoading ? 360 : 0)
            )
            .animation(
                Animation
                    .timingCurve(0.5, 0.25, 0.35, 0.5, duration: 0.65)
                    .repeatForever(autoreverses: false), value: isLoading
            )
            .onAppear {
                self.isLoading = true
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
