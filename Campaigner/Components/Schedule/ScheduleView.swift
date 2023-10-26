//
//  ScheduleView.swift
//  Campaigner
//
//  Created by Macbook  on 18/10/2023.
//
import SwiftUI
struct ScheduleView: View {
    var label: String
    @Binding var selectedDate: Date
    @Binding var selectedTime: Date
    var isMandatory: Bool = true
    
    @State private var showDatePicker: Bool = false
    @State private var showTimePicker: Bool = false
    
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


            
            HStack(spacing: 20) {
                Button(action: {
                    self.showDatePicker.toggle()
                }) {
                    Text(selectedDate, formatter: dateFormatter)
                        .foregroundColor(.black)
                }
                .frame(width: 140, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.black, lineWidth: 1)
                )
                .sheet(isPresented: $showDatePicker, content: {
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                })
                
                Button(action: {
                    self.showTimePicker.toggle()
                }) {
                    Text(selectedTime, formatter: timeFormatter)
                        .foregroundColor(.black)
                }
                .frame(width: 140, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.black, lineWidth: 1)
                )
                .actionSheet(isPresented: $showTimePicker, content: {
                    ActionSheet(title: Text("Select Time"), message: nil, buttons: [
                        .default(Text("Done"), action: {
                            // Close the action sheet
                        }),
                        .cancel()
                    ])
                })
                .background(
                    DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(label: "Schedule", selectedDate: .constant(Date()), selectedTime: .constant(Date()), isMandatory: true)
    }
}
