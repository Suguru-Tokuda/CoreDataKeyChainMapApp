//
//  PetsViewModel.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/23/23.
//

import SwiftUI

class PetsViewModel: ObservableObject {
    @Published var pets: [Pet] = []
    
    @Published var petNameTextFieldText = ""
    @Published var petTypeTextFieldText = ""
    @Published var petWeightTextFieldText = ""
    @Published var petOwnerNameTextFieldText = ""
    
    private var coreDataManager: PetCoreDataActions
    
    init(coreDataManager: PetCoreDataManager = PetCoreDataManager()) {
        self.coreDataManager = coreDataManager
    }
    
    func savePet() {
        guard !petNameTextFieldText.isEmpty,
              !petTypeTextFieldText.isEmpty,
              !petWeightTextFieldText.isEmpty,
              !petOwnerNameTextFieldText.isEmpty else { return }
                
        let newPet = Pet(name: petNameTextFieldText, weight: Double(petWeightTextFieldText) ?? 0, type: petTypeTextFieldText, owner: petOwnerNameTextFieldText)
        
        let petsToSave = pets + [newPet]
        
        Task {
            try await coreDataManager.saveDataIntoDatabase(list: petsToSave)
            DispatchQueue.main.async {
                self.pets = petsToSave
            }
            
        }
        DispatchQueue.main.async {
            self.petNameTextFieldText = ""
            self.petTypeTextFieldText = ""
            self.petWeightTextFieldText = ""
            self.petOwnerNameTextFieldText = ""
        }
    }
    
    func clearPets() {
        Task {
            try await coreDataManager.clearAllFromDatabase()
            let allPets = try await coreDataManager.getDataFromDatabase()
            
            DispatchQueue.main.async {
                self.pets = allPets
            }
        }
    }
    
    func parseResults(results: FetchedResults<PetEntity>) {
        var parsedPets: [Pet] = []
        
        results.forEach { result in
            if let pet = Pet(entity: result) {
                parsedPets.append(pet)
            }
        }
        
        DispatchQueue.main.async {
            self.pets = parsedPets
        }
    }
}
