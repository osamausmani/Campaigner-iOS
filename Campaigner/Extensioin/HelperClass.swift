//
//  HelperClass.swift
//  Campaigner
//
//  Created by Macbook  on 12/07/2023.
//

import Foundation


struct DateFormatterHelper {
    public func formatDateString(_ inputDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let date = dateFormatter.date(from: inputDate) {
            dateFormatter.dateFormat = "dd MMMM yyyy"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    
    public func formatDateStringYMD(_ inputDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: inputDate) {
            dateFormatter.dateFormat = "dd MMMM yyyy"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    

    
}




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

