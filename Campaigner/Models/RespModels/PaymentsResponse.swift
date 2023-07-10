//
//  PaymentsResponse.swift
//  Campaigner
//
//  Created by Macbook  on 20/06/2023.
//

import Foundation


struct ListBanksResponse : Codable {

    let bin : [String]?
    let data : [ListBanks]?
    let extra : [String]?
    let message : String?
    let more : [String]?
    let rescode : Int?


}

struct ListBanks : Codable
{
    let account_no : String?
    let account_title : String?
    let bank_id : String?
    let bank_name : String?

}


struct ListPendingPaymentsResponse : Codable {

    let bin : [String]?
    let data : [ListPendingPayments]?
    let extra : [Extra]?
    let message : String?
    let more : [String]?
    let rescode : Int?


}

struct ListPendingPayments : Codable {

    let can_pay : Int?
    let country_currency_sym : String?
    let fee_cycle : Int?
    let fee_foreign_type : String?
    let fee_id : String?
    let fee_type_text : String?
    let fee_value : Int?
    let pay_due_date : String?
    let pay_status : Int?
    let payment_id : String?

}

struct Extra : Codable
{
    let meta_value : String?
}





