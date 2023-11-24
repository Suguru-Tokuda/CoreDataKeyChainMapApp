//
//  UserDetailsView.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/24/23.
//

import SwiftUI

struct UserDetailsView: View {
    var user: User
    
    var body: some View {
        ScrollView {
            Group {
                VStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    
                    Text(user.name)
                        .font(.largeTitle)
                        .fontWeight(.regular)
                        .foregroundStyle(.white)
                }
                .background(.blue)
                .frame(minHeight: 150)
                
                Group {
                    VStack(alignment: .leading) {
                        Text("Phone")
                            .font(.caption)
                        Text(user.phone)
                            .fontWeight(.semibold)
                    }
                    VStack {
                        Text("Email")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(user.email)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue))
                .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    UserDetailsView(
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
