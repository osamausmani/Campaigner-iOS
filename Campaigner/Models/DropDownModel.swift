//
//  DropDownModel.swift
//  Campaigner
//
//  Created by Osama Usmani on 23/05/2023.
//

import Foundation

struct DropDownModel: Equatable, Identifiable {
    var id: String = ""
    var value: String = ""
    
    static func == (lhs: DropDownModel, rhs: DropDownModel) -> Bool {
          // Define how instances of DropDownModel are compared for equality
          return lhs.id == rhs.id && lhs.value == rhs.value
      }
}

