import SwiftUI

struct AwesomeEmptyView: View {
    var body: some View {
        ZStack {
            Color.blue
            Button("Hello, AwesomeEmptyView!") {

            }
            .font(.title)
            .padding()
        }
    }
}
