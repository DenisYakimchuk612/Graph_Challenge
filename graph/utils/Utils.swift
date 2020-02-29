//
//  Utils.swift
//  graph
//
//  Created by Admin on 2/28/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class Utils {
    public static let testData = """
        {
          "tempdata": {
            "dates": ["2020-01-07", "2020-04-03"],
            "date_start": "2020-01-07",
            "data": [
              {
                "temp": 6779.01,
                "temp_in": 0.0,
                "brix": -34.8,
                "date": "2020-01-07",
                "year": 2020,
                "month": 1,
                "day": 7,
                "timestamp": 1578355200
              },
              {
                "temp": 5843.28,
                "temp_in": 0.0,
                "brix": -935.73,
                "date": "2020-01-08",
                "year": 2020,
                "month": 1,
                "day": 8,
                "timestamp": 1578441600
              },
              {
                "temp": 4142.7,
                "temp_in": 0.0,
                "brix": -1700.58,
                "date": "2020-01-09",
                "year": 2020,
                "month": 1,
                "day": 9,
                "timestamp": 1578528000
              },
              {
                "temp": 4084.91,
                "temp_in": 0.0,
                "brix": -57.79,
                "date": "2020-01-10",
                "year": 2020,
                "month": 1,
                "day": 10,
                "timestamp": 1578614400
              },
              {
                "temp": 3965.36,
                "temp_in": 0.0,
                "brix": -119.55,
                "date": "2020-01-11",
                "year": 2020,
                "month": 1,
                "day": 11,
                "timestamp": 1578700800
              },
              {
                "temp": 2575.07,
                "temp_in": 1136.4,
                "brix": -2526.69,
                "date": "2020-01-14",
                "year": 2020,
                "month": 1,
                "day": 14,
                "timestamp": 1578960000
              },
              {
                "temp": 706.1,
                "temp_in": 0.0,
                "brix": -1868.97,
                "date": "2020-01-15",
                "year": 2020,
                "month": 1,
                "day": 15,
                "timestamp": 1579046400
              },
              {
                "temp": -363.93,
                "temp_in": 0.0,
                "brix": -1070.03,
                "date": "2020-01-16",
                "year": 2020,
                "month": 1,
                "day": 16,
                "timestamp": 1579132800
              },
              {
                "temp": -1982.93,
                "temp_in": 0.0,
                "brix": -1619.0,
                "date": "2020-01-17",
                "year": 2020,
                "month": 1,
                "day": 17,
                "timestamp": 1579219200
              },
              {
                "temp": -3138.41,
                "temp_in": 0.0,
                "brix": -1155.48,
                "date": "2020-01-18",
                "year": 2020,
                "month": 1,
                "day": 18,
                "timestamp": 1579305600
              },
              {
                "temp": -3296.89,
                "temp_in": 0.0,
                "brix": -158.48,
                "date": "2020-01-20",
                "year": 2020,
                "month": 1,
                "day": 20,
                "timestamp": 1579478400
              },
              {
                "temp": -3742.77,
                "temp_in": 0.0,
                "brix": -445.88,
                "date": "2020-01-21",
                "year": 2020,
                "month": 1,
                "day": 21,
                "timestamp": 1579564800
              },
              {
                "temp": -4311.97,
                "temp_in": 0.0,
                "brix": -569.2,
                "date": "2020-01-22",
                "year": 2020,
                "month": 1,
                "day": 22,
                "timestamp": 1579651200
              },
              {
                "temp": -4449.47,
                "temp_in": 0.0,
                "brix": -137.5,
                "date": "2020-01-23",
                "year": 2020,
                "month": 1,
                "day": 23,
                "timestamp": 1579737600
              },
              {
                "temp": -4520.74,
                "temp_in": 0.0,
                "brix": -71.27,
                "date": "2020-01-24",
                "year": 2020,
                "month": 1,
                "day": 24,
                "timestamp": 1579824000
              },
              {
                "temp": -5248.73,
                "temp_in": 0.0,
                "brix": -727.99,
                "date": "2020-01-25",
                "year": 2020,
                "month": 1,
                "day": 25,
                "timestamp": 1579910400
              },
              {
                "temp": -5720.91,
                "temp_in": 0.0,
                "brix": -472.18,
                "date": "2020-01-28",
                "year": 2020,
                "month": 1,
                "day": 28,
                "timestamp": 1580169600
              },
              {
                "temp": -6758.93,
                "temp_in": 0.0,
                "brix": -1038.02,
                "date": "2020-01-29",
                "year": 2020,
                "month": 1,
                "day": 29,
                "timestamp": 1580256000
              },
              {
                "temp": -6832.93,
                "temp_in": 0.0,
                "brix": -74.0,
                "date": "2020-01-30",
                "year": 2020,
                "month": 1,
                "day": 30,
                "timestamp": 1580342400
              },
              {
                "temp": -6958.49,
                "temp_in": 0.0,
                "brix": -125.56,
                "date": "2020-01-31",
                "year": 2020,
                "month": 1,
                "day": 31,
                "timestamp": 1580428800
              },
              {
                "temp": -7758.49,
                "temp_in": 0.0,
                "brix": -800.0,
                "date": "2020-02-01",
                "year": 2020,
                "month": 2,
                "day": 1,
                "timestamp": 1580515200
              },
              {
                "temp": -7958.49,
                "temp_in": 0.0,
                "brix": -200.0,
                "date": "2020-02-02",
                "year": 2020,
                "month": 2,
                "day": 2,
                "timestamp": 1580601600
              },
              {
                "temp": -8310.08,
                "temp_in": 0.0,
                "brix": -351.59,
                "date": "2020-02-04",
                "year": 2020,
                "month": 2,
                "day": 4,
                "timestamp": 1580774400
              },
              {
                "temp": -9017.58,
                "temp_in": 0.0,
                "brix": -707.5,
                "date": "2020-02-05",
                "year": 2020,
                "month": 2,
                "day": 5,
                "timestamp": 1580860800
              },
              {
                "temp": -9032.58,
                "temp_in": 0.0,
                "brix": -15.0,
                "date": "2020-02-06",
                "year": 2020,
                "month": 2,
                "day": 6,
                "timestamp": 1580947200
              },
              {
                "temp": -9180.4,
                "temp_in": 0.0,
                "brix": -147.82,
                "date": "2020-02-07",
                "year": 2020,
                "month": 2,
                "day": 7,
                "timestamp": 1581033600
              },
              {
                "temp": -9438.13,
                "temp_in": 0.0,
                "brix": -257.73,
                "date": "2020-02-08",
                "year": 2020,
                "month": 2,
                "day": 8,
                "timestamp": 1581120000
              },
              {
                "temp": -9714.79,
                "temp_in": 0.0,
                "brix": -276.66,
                "date": "2020-02-09",
                "year": 2020,
                "month": 2,
                "day": 9,
                "timestamp": 1581206400
              },
              {
                "temp": -10000.4,
                "temp_in": 0.0,
                "brix": -285.61,
                "date": "2020-02-11",
                "year": 2020,
                "month": 2,
                "day": 11,
                "timestamp": 1581379200
              },
              {
                "temp": -12773.52,
                "temp_in": 0.0,
                "brix": -2773.12,
                "date": "2020-02-12",
                "year": 2020,
                "month": 2,
                "day": 12,
                "timestamp": 1581465600
              },
              {
                "temp": -13603.9,
                "temp_in": 0.0,
                "brix": -830.38,
                "date": "2020-02-13",
                "year": 2020,
                "month": 2,
                "day": 13,
                "timestamp": 1581552000
              },
              {
                "temp": -14605.48,
                "temp_in": 0.0,
                "brix": -1001.58,
                "date": "2020-02-14",
                "year": 2020,
                "month": 2,
                "day": 14,
                "timestamp": 1581638400
              },
              {
                "temp": -15876.16,
                "temp_in": 19.72,
                "brix": -1290.4,
                "date": "2020-02-15",
                "year": 2020,
                "month": 2,
                "day": 15,
                "timestamp": 1581724800
              },
              {
                "temp": -16152.82,
                "temp_in": 0.0,
                "brix": -276.66,
                "date": "2020-02-16",
                "year": 2020,
                "month": 2,
                "day": 16,
                "timestamp": 1581811200
              },
              {
                "temp": -16912.44,
                "temp_in": 0.0,
                "brix": -759.62,
                "date": "2020-02-18",
                "year": 2020,
                "month": 2,
                "day": 18,
                "timestamp": 1581984000
              },
              {
                "temp": -18506.42,
                "temp_in": 0.0,
                "brix": -1593.98,
                "date": "2020-02-19",
                "year": 2020,
                "month": 2,
                "day": 19,
                "timestamp": 1582070400
              },
              {
                "temp": -18711.16,
                "temp_in": 0.0,
                "brix": -204.74,
                "date": "2020-02-20",
                "year": 2020,
                "month": 2,
                "day": 20,
                "timestamp": 1582156800
              },
              {
                "temp": -19246.14,
                "temp_in": 0.0,
                "brix": -534.98,
                "date": "2020-02-21",
                "year": 2020,
                "month": 2,
                "day": 21,
                "timestamp": 1582243200
              },
              {
                "temp": -19258.15,
                "temp_in": 0.0,
                "brix": -12.01,
                "date": "2020-02-22",
                "year": 2020,
                "month": 2,
                "day": 22,
                "timestamp": 1582329600
              },
              {
                "temp": -20410.03,
                "temp_in": 0.0,
                "brix": -1151.88,
                "date": "2020-02-25",
                "year": 2020,
                "month": 2,
                "day": 25,
                "timestamp": 1582588800
              },
              {
                "temp": -20585.65,
                "temp_in": 0.0,
                "brix": -175.62,
                "date": "2020-02-26",
                "year": 2020,
                "month": 2,
                "day": 26,
                "timestamp": 1582675200
              },
              {
                "temp": -20600.63,
                "temp_in": 0.0,
                "brix": -14.98,
                "date": "2020-02-27",
                "year": 2020,
                "month": 2,
                "day": 27,
                "timestamp": 1582761600
              },
              {
                "temp": -22973.23,
                "temp_in": 0.0,
                "brix": -2372.6,
                "date": "2020-02-28",
                "year": 2020,
                "month": 2,
                "day": 28,
                "timestamp": 1582848000
              },
              {
                "temp": -22889.34,
                "temp_in": 99.0,
                "brix": -15.11,
                "date": "2020-02-29",
                "year": 2020,
                "month": 2,
                "day": 29,
                "timestamp": 1582934400
              },
              {
                "temp": -23689.34,
                "temp_in": 0.0,
                "brix": -800.0,
                "date": "2020-03-01",
                "year": 2020,
                "month": 3,
                "day": 1,
                "timestamp": 1583020800
              },
              {
                "temp": -23889.34,
                "temp_in": 0.0,
                "brix": -200.0,
                "date": "2020-03-02",
                "year": 2020,
                "month": 3,
                "day": 2,
                "timestamp": 1583107200
              },
              {
                "temp": -25487.3,
                "temp_in": 0.0,
                "brix": -1597.96,
                "date": "2020-03-03",
                "year": 2020,
                "month": 3,
                "day": 3,
                "timestamp": 1583193600
              },
              {
                "temp": -26035.76,
                "temp_in": 0.0,
                "brix": -548.46,
                "date": "2020-03-04",
                "year": 2020,
                "month": 3,
                "day": 4,
                "timestamp": 1583280000
              },
              {
                "temp": -26834.76,
                "temp_in": 0.0,
                "brix": -799.0,
                "date": "2020-03-05",
                "year": 2020,
                "month": 3,
                "day": 5,
                "timestamp": 1583366400
              },
              {
                "temp": -27682.76,
                "temp_in": 0.0,
                "brix": -848.0,
                "date": "2020-03-06",
                "year": 2020,
                "month": 3,
                "day": 6,
                "timestamp": 1583452800
              },
              {
                "temp": -28140.49,
                "temp_in": 0.0,
                "brix": -457.73,
                "date": "2020-03-07",
                "year": 2020,
                "month": 3,
                "day": 7,
                "timestamp": 1583539200
              },
              {
                "temp": -28967.6,
                "temp_in": 0.0,
                "brix": -827.11,
                "date": "2020-03-08",
                "year": 2020,
                "month": 3,
                "day": 8,
                "timestamp": 1583625600
              },
              {
                "temp": -29167.6,
                "temp_in": 0.0,
                "brix": -200.0,
                "date": "2020-03-10",
                "year": 2020,
                "month": 3,
                "day": 10,
                "timestamp": 1583798400
              },
              {
                "temp": -30096.59,
                "temp_in": 0.0,
                "brix": -928.99,
                "date": "2020-03-11",
                "year": 2020,
                "month": 3,
                "day": 11,
                "timestamp": 1583884800
              },
              {
                "temp": -30276.17,
                "temp_in": 0.0,
                "brix": -179.58,
                "date": "2020-03-12",
                "year": 2020,
                "month": 3,
                "day": 12,
                "timestamp": 1583971200
              },
              {
                "temp": -32271.95,
                "temp_in": 0.0,
                "brix": -1995.78,
                "date": "2020-03-13",
                "year": 2020,
                "month": 3,
                "day": 13,
                "timestamp": 1584057600
              },
              {
                "temp": -32433.14,
                "temp_in": 0.0,
                "brix": -161.19,
                "date": "2020-03-14",
                "year": 2020,
                "month": 3,
                "day": 14,
                "timestamp": 1584144000
              },
              {
                "temp": -33433.14,
                "temp_in": 0.0,
                "brix": -1000.0,
                "date": "2020-03-15",
                "year": 2020,
                "month": 3,
                "day": 15,
                "timestamp": 1584230400
              },
              {
                "temp": -33785.14,
                "temp_in": 0.0,
                "brix": -352.0,
                "date": "2020-03-17",
                "year": 2020,
                "month": 3,
                "day": 17,
                "timestamp": 1584403200
              },
              {
                "temp": -34789.37,
                "temp_in": 592.8,
                "brix": -1597.03,
                "date": "2020-03-18",
                "year": 2020,
                "month": 3,
                "day": 18,
                "timestamp": 1584489600
              },
              {
                "temp": -34349.35,
                "temp_in": 500.0,
                "brix": -59.98,
                "date": "2020-03-20",
                "year": 2020,
                "month": 3,
                "day": 20,
                "timestamp": 1584662400
              },
              {
                "temp": -34369.7,
                "temp_in": 0.0,
                "brix": -20.35,
                "date": "2020-03-21",
                "year": 2020,
                "month": 3,
                "day": 21,
                "timestamp": 1584748800
              },
              {
                "temp": -34456.19,
                "temp_in": 0.0,
                "brix": -86.49,
                "date": "2020-03-24",
                "year": 2020,
                "month": 3,
                "day": 24,
                "timestamp": 1585008000
              },
              {
                "temp": -35199.98,
                "temp_in": 0.0,
                "brix": -743.79,
                "date": "2020-03-25",
                "year": 2020,
                "month": 3,
                "day": 25,
                "timestamp": 1585094400
              },
              {
                "temp": -35377.9,
                "temp_in": 0.0,
                "brix": -177.92,
                "date": "2020-03-26",
                "year": 2020,
                "month": 3,
                "day": 26,
                "timestamp": 1585180800
              },
              {
                "temp": -36321.86,
                "temp_in": 0.0,
                "brix": -943.96,
                "date": "2020-03-27",
                "year": 2020,
                "month": 3,
                "day": 27,
                "timestamp": 1585267200
              },
              {
                "temp": -36644.05,
                "temp_in": 0.0,
                "brix": -322.19,
                "date": "2020-03-28",
                "year": 2020,
                "month": 3,
                "day": 28,
                "timestamp": 1585353600
              },
              {
                "temp": -36948.93,
                "temp_in": 0.0,
                "brix": -304.88,
                "date": "2020-03-31",
                "year": 2020,
                "month": 3,
                "day": 31,
                "timestamp": 1585612800
              },
              {
                "temp": -39163.77,
                "temp_in": 0.0,
                "brix": -2214.84,
                "date": "2020-04-01",
                "year": 2020,
                "month": 4,
                "day": 1,
                "timestamp": 1585699200
              },
              {
                "temp": -40716.75,
                "temp_in": 0.0,
                "brix": -1552.98,
                "date": "2020-04-02",
                "year": 2020,
                "month": 4,
                "day": 2,
                "timestamp": 1585785600
              },
              {
                "temp": -40918.02,
                "temp_in": 0.0,
                "brix": -201.27,
                "date": "2020-04-03",
                "year": 2020,
                "month": 4,
                "day": 3,
                "timestamp": 1585872000
              }
            ]
          }
        }
    """
    
    public static func getShortTime(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MM/dd"
        
        return dateFormatter.string(from: date)
    }
    
    public static func getMonth(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMMM"
        
        return dateFormatter.string(from: date)
    }
    
    public static func getDateString(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd"
        
        return dateFormatter.string(from: date)
    }
    
    public static func getDate(dateString: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: dateString) ?? Date()
    }
    
    public static func parseJSon(data: String) -> Array<PointData> {
        let removedEnter = data.replacingOccurrences(of: "\n", with: "")
        let removedSpace = removedEnter.replacingOccurrences(of: " ", with: "")
        let data = removedSpace.data(using: String.Encoding.utf8, allowLossyConversion: true)
        var result = Array<PointData>()
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            
            let tempData = json.object(forKey: "tempdata") as! NSDictionary
            let pointArray = tempData.object(forKey: "data") as! Array<Any>
            for point in pointArray {
                if let pointDictionary = point as? NSDictionary {
                    let pointData = PointData()
                    pointData.brix = pointDictionary.object(forKey: "brix") as! Double
                    pointData.temp = pointDictionary.object(forKey: "temp") as! Double
                    let dateString = pointDictionary.object(forKey: "date") as! String
                    pointData.date = getDate(dateString: dateString)
                    pointData.timeStamp = pointDictionary.object(forKey: "timestamp") as! Int
                    
                    result.append(pointData)
                }
            }
            
            result.sort(by: {(left, right) -> Bool in
                return left.date < right.date
            })
        } catch {
            
        }
        
        return result
    }
}
