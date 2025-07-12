//
//  ServiceDetailView.swift
//  Service Management
//
//  Created by Manikandan Arumugam on 12/07/25.
//

import SwiftUI
import ServicesSampleData
import MapKit

struct ServiceDetailView: View {
    let service: Service
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 34.05266737696128, longitude: -118.30003712916758), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    @State private var camera = MapCameraPosition.self
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Map(initialPosition: .region(region)) {
                    Marker(service.location, systemImage: "location.north.circle.fill", coordinate: region.center)
                }
                    .frame(height: 200)
                    .cornerRadius(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.clear)
                            .stroke(.gray, lineWidth: 1)
                    )
                
                HStack {
                    Text(service.title)
                        .font(.system(size: 22, weight: .bold))
                    
                    Spacer()
                    
                    StatusView(service: service)
                }
                
                DetailView(imageName: "person.circle", title: "Customer", description: service.customerName)
                
                DetailView(imageName: "text.document", title: "Description", description: service.description)
                
                DetailView(imageName: "clock", title: "Scheduled Time", description: service.getdate)
                
                DetailView(imageName: "location", title: "Location", description: service.location)
                
                DetailView(imageName: "text.bubble", title: "Service Notes", description: service.serviceNotes)
                
            }
            .padding()
            .navigationTitle("Service Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.white, for: .navigationBar)
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}


struct DetailView: View {
    let imageName: String
    let title: String
    let description: String
    var alignment: VerticalAlignment = .top
    var fontWeight: Font.Weight = .bold
    
    var body: some View {
        HStack(alignment: alignment) {
            Image(systemName: imageName)
                .imageScale(.large)
                .fontWeight(fontWeight)
                .foregroundStyle(.blue)
            
            VStack(alignment: .leading, spacing: 8) {
                if !title.isEmpty {
                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                }
                
                Text(description)
                    .font(.system(size: 14, weight: .regular))
            }
            
            Spacer()
        }
    }
}
