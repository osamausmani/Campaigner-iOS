//
//  ScheduleView.swift
//  Campaigner
//
//  Created by Macbook  on 27/11/2023.
//

import SwiftUI

struct ScheduleView: View {
    var label: String
    var isMandatory: Bool = true
    
    var showDatePicker: () -> Void
    var showTimePicker: () -> Void
    
    @Binding var selectedDate: Date
    @Binding var selectedTime: Date
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                    .font(.system(size: 15))
                if isMandatory {
                    Text("*")
                        .foregroundColor(.red)
                        .font(.system(size: 15))
                }
                Spacer()
            }
            
            HStack {
                Button(action: {
                    self.showDatePicker()
                }) {
                    Text(selectedDate, formatter: dateFormatter)
                        .foregroundColor(.black)
                }
                .frame(width: 140, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.black, lineWidth: 1)
                )
                
                Button(action: {
                    self.showTimePicker()
                }) {
                    Text(selectedTime, formatter: timeFormatter)
                        .foregroundColor(.black)
                }
                .frame(width: 140, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.black, lineWidth: 1)
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ScheduleView(
        label: "Schedule",
        isMandatory: true,
        showDatePicker: {},
        showTimePicker: {},
        selectedDate: .constant(Date()),
        selectedTime: .constant(Date())
    )
}
