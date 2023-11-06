//
//  DataPicker.swift
//  Campaigner
//
//  Created by Osama Usmani on 04/11/2023.
//

import Foundation
import SwiftUI


struct DataPicker: View {
    var label: String
    var placeholder: String
    var isMandatory = false
    
    @Binding var selectedDate: Date
    @Binding var sDate: String
    @Binding var minimumDate: Date
    @State var maximumDate: Date?
    @State var isPresentingFullScreen = false
    
    var body: some View {
        VStack{
            HStack{
                Text(label).alignmentGuide(.leading) { _ in 0 }
                    .font(.system(size: 15))
                isMandatory ? Text("*").foregroundColor(.red) :nil
                Spacer()
            }
            HStack{
                Text(sDate == "" ? placeholder : sDate).alignmentGuide(.leading) { _ in 0 }
                    .font(.system(size: 16)).foregroundColor(sDate == "" ? .gray : .black).padding(10).onTapGesture {
                        isPresentingFullScreen.toggle()
                    }
                
                
                Spacer()
                
            }.frame(maxHeight: 40).overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1)
            )
            Spacer()
        }.padding(1).onAppear{
        } .onChange(of: selectedDate) { newValue in
            sDate = formatDate(date: newValue)
            
        }.sheet(isPresented: $isPresentingFullScreen) {
            datePickerPopup
        }
        
        
        
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    var datePickerPopup: some View {
        DatePicker("Select a Date", selection: $selectedDate, in: (minimumDate ?? minSelectableDate)...(maximumDate ?? Date()), displayedComponents: [.date])
            .datePickerStyle(GraphicalDatePickerStyle())
            .labelsHidden()
            .padding()
            .navigationBarTitle("Date Picker", displayMode: .inline).onAppear{
                print("selectedDate", selectedDate)
                print("minimumDate", minimumDate)
            }
    }
    
    // DateFormatter to format the selected date
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    
    private var minSelectableDate: Date {
        // Set the minimum selectable date (e.g., January 1, 2020)
        var components = DateComponents()
        components.year = 2020
        components.month = 1
        components.day = 1
        return Calendar.current.date(from: components) ?? Date()
    }
    
}

