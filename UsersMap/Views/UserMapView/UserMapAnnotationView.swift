//
//  UserMapAnnotationView.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/24/23.
//

import SwiftUI

struct UserMapAnnotationView: View {
    var user: User
    @State var isFocused: Bool = false

    var body: some View {
        VStack {
            Group {
                Image(systemName: "person.circle.fill")
                    .font(.title)
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .offset(x: 0, y: isFocused ? -5 : 0)
            }
            .foregroundStyle(.red)
            .scaleEffect(isFocused ? 1 : 1.5)
//            .onTapGesture {
//                withAnimation(.spring) {
//                    self.isFocused.toggle()
//                }
//            }
        }
    }
}

#Preview {
    UserMapAnnotationView(
        user: User(
            id: 1,
            name: "Leanne Graham",
            userName: "Bret",
            email: "Sincere@april.biz",
            phone: "1-770-736-8031 x56442",
            website: "hildegard.org",
            address: Address(street: "Kulas Light",
                             suite: "Apt. 556",
                             city: "Gwenborough",
                             zipcode: "92998-3874",
                             geo: Geo(lat: -37.3159, lng: 81.1496)
                            ),
            company: Company(name: "Romaguera-Crona", catchPhrase: "Multi-layered client-server neural-net", bs: "harness real-time e-markets"))
    )
}
