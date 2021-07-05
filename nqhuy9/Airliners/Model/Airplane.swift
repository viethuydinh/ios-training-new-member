//
//  Airplane.swift
//  Airliners
//
//  Created by Nghiêm Huy on 6/28/21.
//

import Foundation

struct Airplane {
    var image: String
    var title : String
    var model: String
    var shortInfo: String
    var infomation: AirplaneInfomation
    
}


extension Airplane {
    
    static let airplaneModel707: Airplane = Airplane(image: "https://upload.wikimedia.org/wikipedia/commons/0/06/Boeing_707-321B_Pan_Am_Freer.jpg", title: "The Boeing 707", model: "707", shortInfo: "Mid-sized, mid- to long-range, narrow-body, four-engine jet airliner", infomation: AirplaneInfomation(longDescription: "The Boeing 707 is an American mid-sized, mid- to long-range, narrow-body, four-engine jet airliner built by Boeing Commercial Airplanes from 1958 to 1979. Versions of the aircraft have a capacity from 140 to 219 passengers and a range of 2,500 to 5,750 nautical miles (2,880 to 6,620 mi; 4,630 to 10,650 km).", nation: "United States", manufaturer: "Boeing Commercial Airplanes", firstFlight: "December 20,1957", produced: "1956-1978", numberBuilt: "865", status: "In limited military and chapter service"))
    
    static let airplaneModel717: Airplane = Airplane(image: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Delta_Air_Lines_Boeing_717-2BD_N966AT.jpg/1024px-Delta_Air_Lines_Boeing_717-2BD_N966AT.jpg", title: "The Boeing 717", model: "717", shortInfo: "Twin-engine, single-aisle", infomation: AirplaneInfomation(longDescription: "The Boeing 717 is a twin-engine, single-aisle jet airliner, developed for the 100-seat market. The airliner was designed and originally marketed by McDonnell Douglas as the MD-95, a derivative of the DC-9 family. Capable of seating up to 134 passengers, the 717 has a design range of 2,060 nautical miles (3,820 km). It is powered by two Rolls-Royce BR715 turbofan engines mounted at the rear of the fuselage.", nation: "United States", manufaturer: "Boeing Commercial Airplanes", firstFlight: "September 2,1998", produced: "1998-2006", numberBuilt: "156", status: "In service"))
    
    static let airplaneModel727: Airplane = Airplane(image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/57/B-727_Iberia_%28cropped%29.jpg/1024px-B-727_Iberia_%28cropped%29.jpg", title: "The Boeing 727", model: "727", shortInfo: "Midsized, narrow-body three-engined", infomation: AirplaneInfomation(longDescription: "The Boeing 727 is an American midsized, narrow-body three-engined jet aircraft built by Boeing Commercial Airplanes from the early 1960s to 1984. It can carry 149 to 189 passengers and later models can fly up to 2,700 nautical miles (5,000 km) nonstop. Intended for short and medium-length flights, the 727 can use relatively short runways at smaller airports. It has three Pratt & Whitney JT8D engines below a T-tail, one on each side of the rear fuselage with a center engine that connects through an S-duct to an inlet at the base of the fin. The 727 is the only Boeing trijet,[4] as a commercial design entering production.", nation: "United States", manufaturer: "Boeing Commercial Airplanes", firstFlight: "February 1,1964", produced: "1962-1984", numberBuilt: "1832", status: "In service with freighter and executive use"))
    
    static let airplaneModel737: Airplane = Airplane(image: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/South_African_Airlink_Boeing_737-200_Advanced_Smith.jpg/1024px-South_African_Airlink_Boeing_737-200_Advanced_Smith.jpg", title: "The Boeing 737", model: "737", shortInfo: "Twin‑engine, single aisle, short- to medium-range narrow-body", infomation: AirplaneInfomation(longDescription: "The Boeing 737 is an American short- to medium-range twinjet narrow-body airliner developed and manufactured by Boeing Commercial Airplanes. Originally developed as a shorter, lower-cost twin-engine airliner derived from the 707 and 727, the 737 has developed into a family of several passenger models with capacities from 85 to 215 passengers. The 737 is currently Boeing's only narrow-body airliner, with the 737 Next Generation (-700, -800, and -900ER), and the re-engined and updated 737 MAX variants in production.", nation: "United States", manufaturer: "Boeing", firstFlight: "April 9,1967", produced: "1966-present", numberBuilt: "10692", status: "In service"))
    
    static let airplaneModel747: Airplane = Airplane(image: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/B-747_Iberia.jpg/1024px-B-747_Iberia.jpg", title: "The Boeing 747", model: "747", shortInfo: "Heavy, four‑engine, partial double deck, twin–aisle main deck, single–aisle upper deck, medium- to long-range widebody", infomation: AirplaneInfomation(longDescription: "The Boeing 747 is an American wide-body commercial jet airliner and cargo aircraft. The first wide-body airplane produced, it was the first plane dubbed a \"Jumbo Jet\". Its distinctive hump upper deck along the forward part of the aircraft has made it one of the most recognizable aircraft. Manufactured by Boeing's Commercial Airplane unit in the United States, the 747 was originally planned to have 150 percent greater capacity than the Boeing 707, a common large commercial aircraft of the 1960s. First flown commercially in 1970, the 747 held the passenger capacity record for 37 years.", nation: "United States", manufaturer: "Boeing Comercial Airplanes", firstFlight: "February 9,1969", produced: "1968-present", numberBuilt: "1564", status: "In service"))
    
    static let ListFakeAirplane = [Airplane.airplaneModel707,
                                   Airplane.airplaneModel717,
                                   Airplane.airplaneModel727,
                                   Airplane.airplaneModel737,
                                   Airplane.airplaneModel747]
}
