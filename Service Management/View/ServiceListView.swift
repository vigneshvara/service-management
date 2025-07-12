//
//  ContentView.swift
//  Service Management
//
//  Created by Manikandan Arumugam on 12/07/25.
//

import SwiftUI
import ServicesSampleData

struct ServiceListView: View {
    @StateObject var viewModel = ServiceViewModel()
    @State var selectedService: Service?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if !viewModel.searchText.isEmpty && viewModel.filteredServices.isEmpty {
                    Image(systemName: "questionmark.text.page")
                        .resizable()
                        .frame(width: 100, height: 130)
                        .foregroundStyle(.gray)
                        .padding(.bottom, 20)
                    
                    Text("No Service Found!!!")
                } else {
                    List(viewModel.searchText.isEmpty ? viewModel.services : viewModel.filteredServices) { service in
                        ServiceView(service: service)
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                selectedService = service
                            }
                    }
                    .listRowSpacing(0)
                    .listStyle(.plain)
                    .scrollIndicators(.hidden)
                }
            }
            .navigationTitle("Service")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(item: $selectedService, destination: { service in
                ServiceDetailView(service: service)
            })
            .searchable(text: $viewModel.searchText)
            .toolbarBackground(.white, for: .navigationBar)
        }
    }
}

struct ServiceView: View {
    let service: Service
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .center) {
                Text(service.title)
                    .font(.headline)
                
                Spacer()
                
                Circle()
                    .fill(service.priority.getColor)
                    .frame(width: 10, height: 10)
            }
            
            DetailView(imageName: "person.circle", title: "", description: service.customerName, alignment: .center, fontWeight: .medium)
            
            DetailView(imageName: "text.document", title: "", description: service.description, fontWeight: .medium)
            
            HStack {
                StatusView(service: service)
                
                Spacer()
                
                Text(service.getdate)
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.clear)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

struct StatusView: View {
    let service: Service
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(service.status.color.opacity(0.5))
                .frame(width: 15, height: 15)
            
            Text(service.status.rawValue)
                .font(.subheadline)
                .foregroundStyle(service.status.color)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(service.status.color.opacity(0.1))
                .stroke(service.status.color.opacity(0.2), lineWidth: 1)
        )
    }
}
