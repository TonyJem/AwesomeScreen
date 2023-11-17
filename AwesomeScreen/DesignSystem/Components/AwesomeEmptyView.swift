import SwiftUI

struct AwesomeEmptyView: View {
    var body: some View {
        ZStack {
            Color.red
            Button("Hello, AwesomeEmptyView!") {

            }
            .font(.title)
            .padding()
        }
    }
}
