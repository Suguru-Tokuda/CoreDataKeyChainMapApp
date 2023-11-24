//
//  PetViews.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/23/23.
//

import SwiftUI
import CoreData

struct PetsView: View {
    @StateObject var vm: PetsViewModel = PetsViewModel()
    @FetchRequest(entity: PetEntity.entity(), sortDescriptors: [])
    var results: FetchedResults<PetEntity>
    var request: NSFetchRequest<PetEntity> = PetEntity.fetchRequest()
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                HStack {
                    TextField("Pet name", text: $vm.petNameTextFieldText)
                    TextField("Type", text: $vm.petTypeTextFieldText)
                }
                HStack {
                    TextField("Pet weight (lb)", text: $vm.petWeightTextFieldText)
                        .keyboardType(.numberPad)
                    TextField("Pet owner", text: $vm.petOwnerNameTextFieldText)
                }
                Button(action: {
                    vm.savePet()
                }, label: {
                    Text("Save Pet")
                })
                .buttonStyle(.borderedProminent)
                if !vm.pets.isEmpty {
                    Button(action: {
                        vm.clearPets()
                    }, label: {
                        Text("Clear All")
                    })
                }
            }
            List {
                ForEach(vm.pets) { pet in
                    PetCellView(pet: pet)
                }
            }
        }
        .onAppear {
            vm.parseResults(results: results)
        }
        .padding(10)
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    PetsView()
}
