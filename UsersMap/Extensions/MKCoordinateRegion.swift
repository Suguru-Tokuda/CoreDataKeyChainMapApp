//
//  MKCoordinateRegion.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/22/23.
//

import Foundation
import CoreLocation
import SwiftUI
import MapKit

extension MKCoordinateRegion {
    func getBinding() -> Binding<MKCoordinateRegion>? {
        return Binding<MKCoordinateRegion>(.constant(self))
    }
}
