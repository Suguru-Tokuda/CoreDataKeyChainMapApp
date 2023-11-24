//
//  PetCoreDataManager.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/23/23.
//

import Foundation
import CoreData

protocol PetCoreDataActions {
    func saveDataIntoDatabase(list: [Pet]) async throws
    func getDataFromDatabase() async throws -> [Pet]
    func deleteFromDatabase(entry: PetEntity) async throws
    func clearAllFromDatabase() async throws
}

class PetCoreDataManager: PetCoreDataActions {
    func saveDataIntoDatabase(list: [Pet]) async throws {
        try await clearAllFromDatabase()
        
        try await PersistenceController.shared.container.performBackgroundTask { privateContext in
            list.forEach { pet in
                let petEntity = PetEntity(context: privateContext)
                let petOwnerEntity = PetOwnerEntity(context: privateContext)
                
                petEntity.id = pet.id
                petEntity.name = pet.name
                petEntity.weight = pet.weight
                petEntity.type = pet.type
                petOwnerEntity.name = pet.owner
                
                petEntity.petPetOwnerRelationship = petOwnerEntity
            }
            
            do {
                try self.save(context: privateContext)
            } catch {
                throw error
            }
        }
        
    }
    
    func getDataFromDatabase() async throws -> [Pet] {
        let request: NSFetchRequest<PetEntity> = PetEntity.fetchRequest()
        var retVal: [Pet] = []
        
        try await PersistenceController.shared.container.performBackgroundTask { privateContext in
            let allRecords = try privateContext.fetch(request)
            allRecords.forEach { entity in
                if let id = entity.id,
                   let name = entity.name,
                   let type = entity.type,
                   let owner = entity.petPetOwnerRelationship,
                   let ownerName = owner.name
                {
                    retVal.append(Pet(id: id, name: name, weight: entity.weight, type: type, owner: ownerName ))
                }
            }
        }
        
        return retVal
    }
    
    func deleteFromDatabase(entry: PetEntity) async throws {
        try await PersistenceController.shared.container.performBackgroundTask { privateContext in
            privateContext.delete(entry)
            do {
                try self.save(context: privateContext)
            } catch {
                throw error
            }
        }
    }
    
    func save(context: NSManagedObjectContext) throws {
        do {
            try context.save()
        } catch {
            throw error
        }
    }
    
    func clearAllFromDatabase() async throws {
        try await PersistenceController.shared.container.performBackgroundTask { privateContext in
            let request: NSFetchRequest<PetEntity> = PetEntity.fetchRequest()
            let allRecords = try privateContext.fetch(request)
            allRecords.forEach { petEntity in
                if let petOwner = petEntity.petPetOwnerRelationship { privateContext.delete(petOwner) }
                privateContext.delete(petEntity)
            }
            try privateContext.save()
        }
    }
}
