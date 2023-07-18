//
//  HelperClass.swift
//  Campaigner
//
//  Created by Macbook  on 12/07/2023.
//

import Foundation


//struct DateFormatterHelper {
//    static func format(date: Date, inputFormat: String, outputFormat: String) -> String? {
//        let formatter = DateFormatter()
//        formatter.dateFormat = inputFormat
//
//        guard let formattedDate = formatter.date(from: formatter.string(from: date)) else {
//            return nil
//        }
//
//        formatter.dateFormat = outputFormat
//        return formatter.string(from: formattedDate)
//    }
//}


//struct DateFormatterHelper {
//    static func format(inputDate: String, inputFormat: String, outputFormat: String) -> String? {
//        let formatter = DateFormatter()
//        formatter.dateFormat = inputFormat
//        
//        guard let date = formatter.date(from: inputDate) else {
//            return nil
//        }
//        
//        formatter.dateFormat = outputFormat
//        return formatter.string(from: date)
//    }
//}

func convertDate(inputDate: String, inputFormat: String, outputFormat: String) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = inputFormat
    
    guard let date = formatter.date(from: inputDate) else {
        return nil
    }
    
    formatter.dateFormat = outputFormat
    return formatter.string(from: date)
}


     func getStatusString(for status: Int) -> String {
        switch status {
        case 0:
            return "Completed"
        case 2:
            return "Closed"
        default:
            return "Pending"
        }
    }

