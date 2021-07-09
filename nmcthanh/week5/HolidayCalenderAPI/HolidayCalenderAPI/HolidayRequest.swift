//
//  HolidayRequest.swift
//  HolidayCalenderAPI
//
//  Created by Thuy on 7/9/21.
//

import Foundation

struct HolidayRequest {
    let resourceURL: URL
    let API_KEY = "c40f240391440cd0ad933fda66bf796530e96e38"
        
    init(countryCode: String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resoucreString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        
        guard let resourceURL = URL(string: resoucreString) else { fatalError() }
        self.resourceURL = resourceURL
    }
    
    func getHolidays(completion: @escaping (Result<[HolidayDetail], HolidayError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            guard let data = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let holidayResponse = try decoder.decode(HolidayResponse.self, from: data)
                let holidayDetails = holidayResponse.response.holidays
                completion(.success(holidayDetails))
            } catch{
                completion(.failure(.canNotProduceData))
            }
        }
        dataTask.resume()
    }
    
}

enum HolidayError: Error {
    case noDataAvailable
    case canNotProduceData
}
