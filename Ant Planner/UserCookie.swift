//
//  UserCookie.swift
//  Ant Planner
//
//  Created by xiyue on 31/7/2016.
//  Copyright © 2016 Ant Inc. All rights reserved.
//

import Foundation

class UserCookie: NSObject {
    class func addUserCookie() {
        var cookies = [NSHTTPCookie]()
        let url = NSURL(string: "https://www.antplanner.org")!
        
        let userInfo = status.valueForKey("cookies") as! Dictionary<String, String>!
        for (name, value) in userInfo {
            var cookieProperties = [String: AnyObject]()
            cookieProperties[NSHTTPCookieName] = name
            cookieProperties[NSHTTPCookieValue] = value
            cookieProperties[NSHTTPCookieDomain] = url.host
            cookieProperties[NSHTTPCookiePath] = url.path
            
            if let cookie = NSHTTPCookie(properties: cookieProperties) {
                cookies.append(cookie)
            }
        }
        
        NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookies(cookies, forURL: url, mainDocumentURL: nil)
    }
}
