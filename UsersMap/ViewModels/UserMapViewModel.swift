//
//  ProductViewModel.swift
//  ElectronicProducts
//
//  Created by Suguru Tokuda on 11/21/23.
//

import Foundation
import Combine
import CoreData
import SwiftUI
import MapKit

@MainActor
class UserMapViewModel: ObservableObject {
    var users: [User] = []
    
//    @Published var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3159, longitude: -81.1496), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)))
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3159, longitude: -81.1496), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @Published var isErrorOccured: Bool = false
    @Published var isLoading: Bool = false
    @Published var locationAuthorized: Bool = false

    var cancellable = Set<AnyCancellable>()
    var customError: NetworkError?
    private var networkManager: Networking
    private var locationManager: LocationManager
        
    init(networkManager: Networking = NetworkManager(), locationManager: LocationManager = LocationManager()) {
        self.networkManager = networkManager
        self.locationManager = locationManager
        self.addSubscriptions()
        self.getSQLitePath()
    }
    
    deinit {
        cancellable.removeAll()
    }
    
    func requestUserLocationAuthorization() {
        locationManager.locationManager.requestWhenInUseAuthorization()
    }
    
    func addSubscriptions() {
        locationManager.$locationAuthorized
            .receive(on: RunLoop.main)
            .sink { val in
                self.locationAuthorized = val
            }
            .store(in: &cancellable)
                
//        locationManager.$currentLocation
//            .receive(on: RunLoop.main)
//            .sink { val in
//                if let location = val {                    
//                    let coordinate = location.coordinate
//                    self.cameraPosition = .region(
//                        MKCoordinateRegion(
//                            center: CLLocationCoordinate2D(
//                                latitude: coordinate.latitude,
//                                longitude: coordinate.longitude),
//                            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
//                    )
//                }
//            }
//            .store(in: &cancellable)
    }

    func loadUsers(urlString: String = Constants.apiEndpoint) {
        guard !isLoading else { return }
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.isErrorOccured = true
                self.customError = NetworkError.badUrl
            }
            return
        }
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        networkManager.getDataFromNetworkLayer(url: url, type: [User].self)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    switch error {
                    case NetworkError.badUrl:
                        self.customError = NetworkError.badUrl
                    case NetworkError.parsing:
                        self.customError = NetworkError.parsing
                    case NetworkError.dataNotFound:
                        self.customError = NetworkError.dataNotFound
                    case NetworkError.serverNotFound:
                        self.customError = NetworkError.serverNotFound
                    default:
                        self.customError = NetworkError.dataNotFound
                    }
                    
                    self.isErrorOccured = true
                    self.isLoading = false
                }
            } receiveValue: { users in
                self.users = users
                self.isLoading = false
            }
            .store(in: &cancellable)
    }

    func supressError() {
        self.isErrorOccured = false
        self.customError = nil
    }
    
    func getSQLitePath() {
        // .shared, .default, .standard - same thing
        guard let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            return
        }
        
        let sqlitePath = url.appendingPathComponent("PetCoreData")
        
        print(sqlitePath.absoluteString)
    }
}
