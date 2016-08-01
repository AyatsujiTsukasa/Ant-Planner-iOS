//
//  UserCookie.swift
//  Ant Planner
//
//  Created by xiyue on 31/7/2016.
//  Copyright © 2016 Ant Inc. All rights reserved.
//

import Foundation

class Utility: NSObject {
    class func matchesForRegexInText(regex: String!, text: String!) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = text as NSString
            let results = regex.matchesInString(text,
                                                options: [], range: NSMakeRange(0, nsString.length))
            return results.map { nsString.substringWithRange($0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    class func extract(str: String) -> String {
        return str.substringWithRange(Range<String.Index>(str.startIndex.advancedBy(4)..<str.endIndex.advancedBy(-5)))
    }
    
    class func getCookieByName(cookieName: String) -> String {
        var value = ""
        for cookie in NSHTTPCookieStorage.sharedHTTPCookieStorage().cookies! {
            if cookie.name == cookieName {
                value = cookie.value
            }
        }
        return value
    }
}
