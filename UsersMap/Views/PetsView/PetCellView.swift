//
//  PetCellView.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/23/23.
//

import SwiftUI

struct PetCellView: View {
    var pet: Pet
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading) {
                Text("Name")
                    .font(.caption2)
                Text(pet.name)
                    .font(.callout)
                    .fontWeight(.semibold)
            }
            VStack(alignment: .leading) {
                Text("Type")
                    .font(.caption2)
                Text(pet.type)
                    .font(.callout)
                    .fontWeight(.semibold)
            }
            VStack(alignment: .leading) {
                Text("Weight")
                    .font(.caption2)
                Text("\(pet.weight, specifier: "%.2f") lb")
                    .font(.callout)
                    .fontWeight(.semibold)
            }
            VStack(alignment: .leading) {
                Text("Owner")
                    .font(.caption2)
                Text(pet.owner)
                    .font(.callout)
                    .fontWeight(.semibold)
            }
            Spacer()
        }
    }
}

#Preview {
    PetCellView(pet: Pet(id: UUID(), name: "Leo", weight: 90, type: "Dog", owner: "Suguru"))
}
