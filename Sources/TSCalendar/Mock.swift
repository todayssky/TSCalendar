import Foundation
import SwiftUI

let mock: [Int: AnyView] = [
    1: AnyView(MockView(timeString: "10:00", name: "Jamse")),
    4: AnyView(
        VStack(spacing: 10) {
            MockView(timeString: "10:00", name: "Daniel")
            MockView(timeString: "14:00", name: "Jhon")
            MockView(timeString: "17:00", name: "Michel")
            MockView(timeString: "18:00", name: "Kim")
        }
    ),
    8: AnyView(
        VStack(spacing: 10) {
            MockView(timeString: "10:00", name: "Daniel")
            MockView(timeString: "18:00", name: "Kim")
        }
    ),
    9: AnyView(
        Text("Holiday!")
            .foregroundColor(.red)
    ),
    12: AnyView(
        VStack(spacing: 10) {
            MockView(timeString: "10:00", name: "Daniel")
            MockView(timeString: "17:00", name: "Michel")
        }
    )
]

struct MockView: View {
    let timeString: String
    let name: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(timeString)
                Text("🫡")
            }
            Text(name)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
