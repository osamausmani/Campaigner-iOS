//
//  AddLocationView.swift
//  Campaigner
//
//  Created by Macbook  on 10/11/2023.
//

import SwiftUI
import MapKit

struct AddLocationView: View {
    @State private var isPresented = true

    var body: some View {
     
            ZStack {
                GoogleMapView(latitude: "", longitude: "")
                    .ignoresSafeArea(edges: .all)
                    .onTapGesture {
                        
                    }

                VStack(spacing: 0) {
                    CustomNavBarBack(title: "Add Location")
                    
                    VStack {
                        SearchBarView()
                            .padding(.bottom, 10)

                        MainButton(action: {
                            // Handle button action
                        }, label: "Add")
                        .padding([.leading, .trailing], 10)
                        .padding(.bottom, 10)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    )
                    .padding(.horizontal)

                    Spacer()
                }
                .navigationBarHidden(true)
            
            }
        
        .navigationBarHidden(true)
    }
}

struct AddLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationView()
    }
}
struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {

    }
}
