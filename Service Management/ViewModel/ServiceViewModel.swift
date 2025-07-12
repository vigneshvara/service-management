//
//  ObservableObject.swift
//  Service Management
//
//  Created by Manikandan Arumugam on 12/07/25.
//

import Foundation
import ServicesSampleData
import SwiftUI
import Combine

class ServiceViewModel: ObservableObject {
    @Published var services: [Service] = []
    @Published var filteredServices: [Service] = []
    @Published var searchText: String = ""
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        loadServices()
        addSearchPublisher()
    }
    
    func addSearchPublisher() {
        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] text in
                guard let self else { return }
                self.filteredServices = self.services.filter {
                    $0.customerName.lowercased().contains(text.lowercased()) ||
                    $0.description.lowercased().contains(text.lowercased()) ||
                    $0.title.lowercased().contains(text.lowercased())
                }
            })
            .store(in: &cancellables)
    }
    
    func loadServices() {
        DispatchQueue.main.async() {
            self.services = SampleData.generateServices()
        }
    }
}
