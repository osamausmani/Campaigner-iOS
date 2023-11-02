//
//  UserData.swift
//  Campaigner
//
//  Created by Macbook  on 01/11/2023.
//

import SwiftUI

class UserData: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
}
