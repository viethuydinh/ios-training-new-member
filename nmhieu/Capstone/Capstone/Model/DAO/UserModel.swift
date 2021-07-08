//
//  UserModel.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 02/07/2021.
//

import Foundation

struct UserModel {
    var id: Int?
    var username: String?
    var sex: Gender?
    var dateOfBirth : String?
    var email: String?
    var image: String?
    var position : String?
    var descript : String?
}

enum Gender: Int {
    case male = 1
    case female = 2
    case unknow = 3
}


