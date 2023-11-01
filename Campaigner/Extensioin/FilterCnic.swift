//
//  FilterCnic.swift
//  Campaigner
//
//  Created by Osama Usmani on 21/05/2023.
//

import Foundation

func formatCnicPhone(_ text: String, with mask: String) -> String {
     let numbers = text.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
     var result = ""
     var index = numbers.startIndex
     
     for ch in mask {
         if index >= numbers.endIndex {
             break
         }
         
         if ch == "X" {
             result.append(numbers[index])
             index = numbers.index(after: index)
         } else {
             result.append(ch)
         }
     }
     
     return result
 }



