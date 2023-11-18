import SwiftUI

struct AwesomeFailureView: View {

    var body: some View {
        VStack(spacing: .spacingM) {

            VStack(spacing: .spacingXXS) {
                titleText()
                subtitleText()
            }

            Button("Try Again") {
                print("🟢 didTap Action Button in AwesomeFailureView")
            }
            .padding(.vertical, .spacingXS)

        }
        .padding(.horizontal, .spacingXL)
    }

    private func titleText() -> some View {
        Text("Unable to Load Control Unit List")
            .fontWithLineHeight(
                font: .Branded.title,
                lineHeight: 24
            )
            .foregroundColor(Color(.Branded.white))
            .multilineTextAlignment(.center)
    }

    private func subtitleText() -> some View {
        Text("Please try again later.")
            .fontWithLineHeight(
                font: .Branded.subtitle,
                lineHeight: 16
            )
            .foregroundColor(Color(.Branded.white))
            .multilineTextAlignment(.center)
    }
}
