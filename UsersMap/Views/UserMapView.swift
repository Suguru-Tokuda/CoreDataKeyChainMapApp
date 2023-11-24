//
//  UserMapView.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/22/23.
//

import SwiftUI
import MapKit

struct UserMapView: View {
    @StateObject var vm: UserMapViewModel = UserMapViewModel()
    @Namespace var mapScope
    
    var body: some View {
        if vm.locationAuthorized {
            VStack {
                Map(position: $vm.cameraPosition, interactionModes: .all) {
                    ForEach(vm.users) { user in
                        Marker(user.name, coordinate: CLLocationCoordinate2D(latitude: user.address.geo.lat, longitude: user.address.geo.lng))
                    }
                }
                .mapControls {
                    MapUserLocationButton()
                }
            }
            .mapScope(mapScope)
            .onAppear {
                vm.loadUsers()
            }

        } else {
            VStack {
                Image(systemName: "location.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                Text("Location Usage is not allowed.")
                    .font(.callout)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 200)
                Button(action: {
                    vm.requestUserLocationAuthorization()
                }, label: {
                    Text("Authorization Options")
                })
            }
        }
    }
}

#Preview {
    UserMapView()
}
