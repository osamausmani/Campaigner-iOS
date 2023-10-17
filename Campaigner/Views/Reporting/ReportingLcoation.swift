//
//  ReportingLcoation.swift
//  Campaigner
//
//  Created by Macbook  on 14/07/2023.
//

import SwiftUI
import MapKit



struct ReportingLcoation: View {
    
    @StateObject private var alertService = AlertService()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    
    
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 31.5204, longitude: 74.3587), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    
    @State private var annotations: [IdentifiableAnnotation] = []
    
    
    var body: some View {
        NavigationView {
            
            ZStack {
                BaseView(alertService: alertService)
                
                ZStack{
                    ScrollView{
                        headerView( heading: "Location", action: dismissView)
                        VStack {

                            MapScreen(region: $region, annotations: $annotations)
                                .frame(height: 600)
                                .cornerRadius(10)
                                .padding()
                            
                           
                            
                            Spacer()
                            Divider()
                            
                            
                          
                        }.padding(16)
                        
                        
                    }
            
                }
                
                
            }
            .offset(y: kGuardian.slide).animation(.easeInOut(duration: 1.0))
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .onAppear{
                
                region.center.latitude = 0
                region.center.longitude = 0
                let newAnnotation = MKPointAnnotation()
                newAnnotation.coordinate = CLLocationCoordinate2D(latitude:  31.5204, longitude: 74.3587)
                let identifiableAnnotation = IdentifiableAnnotation(annotation: newAnnotation)
                annotations.append(identifiableAnnotation)
            }
            
        }
    }
    
    func dismissView()
    {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct ReportingLcoation_Previews: PreviewProvider {
    static var previews: some View {
        ReportingLcoation()
    }
}
