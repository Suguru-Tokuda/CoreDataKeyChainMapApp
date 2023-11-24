//
//  Pet.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/23/23.
//

import Foundation

struct Pet: Identifiable {
    var id = UUID()
    let name: String
    let weight: Double
    let type: String
    let owner: String
    
    init(name: String, weight: Double, type: String, owner: String) {
        self.name = name
        self.weight = weight
        self.type = type
        self.owner = owner
    }
    
    init(id: UUID, name: String, weight: Double, type: String, owner: String) {
        self.id = id
        self.name = name
        self.weight = weight
        self.type = type
        self.owner = owner
    }
    
    init?(entity: PetEntity) {
        if let id = entity.id,
           let name = entity.name,
           let type = entity.type,
           let owner = entity.petPetOwnerRelationship,
           let ownerName = owner.name {
               self.id = id
               self.name = name
               self.type = type
               self.weight = entity.weight
               self.owner = ownerName
           } else { return nil }
    }
}
