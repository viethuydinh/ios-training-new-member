//
//  File.swift
//  HolidayCalenderAPI
//
//  Created by Thuy on 7/9/21.
//

import Foundation

struct HolidayResponse: Codable {
    var response: Holidays
}

struct Holidays: Codable {
    var holidays: [HolidayDetail]
}

struct HolidayDetail: Codable {
    var name: String
    var date: DateInfo
}

struct DateInfo: Codable {
    var iso: String
}
