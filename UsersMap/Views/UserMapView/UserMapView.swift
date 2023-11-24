//
//  UserMapView.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/22/23.
//

import SwiftUI
import MapKit

struct UserMapView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    @StateObject var vm: UserMapViewModel = UserMapViewModel()
    @Namespace var mapScope
    
    var body: some View {
        if vm.locationAuthorized {
            VStack {
                Map(coordinateRegion: $vm.region, annotationItems: vm.users) { user in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: user.address.geo.lat, longitude: user.address.geo.lng)) {
                        UserMapAnnotationView(user: user)
                            .onTapGesture {
                                coordinator.goToUserDetailsView(user: user)
                            }
                    }
                }
////                Map(position: $vm.cameraPosition, interactionModes: .all) {
//                    ForEach(vm.users) { user in
//                        Marker(coordinate: CLLocationCoordinate2D(latitude: user.address.geo.lat, longitude: user.address.geo.lng)) {
//                            UserMapAnnotationView(user: user)
//                                .background(
//                                    Text("tap")
//                                        .onTapGesture {
//                                            print("background tapped")
//                                        }
//                                )
//                        }
//                    }
//                }
//                .mapControls {
//                    MapUserLocationButton()
//                }
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
        .environmentObject(MainCoordinator())
}
