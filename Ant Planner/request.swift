//
//  request.swift
//  Ant Planner
//
//  Created by Desperado on 7/4/28 H.
//  Copyright © 28 Heisei Ant Inc. All rights reserved.
//

import Foundation

//func sendRequest(method: String, url: String, form: String) {
//    let request = NSMutableURLRequest(URL: NSURL(string: url)!)
//    request.HTTPMethod = method
//    let postString = form
//    request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
//    
//    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {data, response, error in
//        guard error == nil && data != nil else {
//            print("error=\(error)")
//            return
//        }
//        
//        if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
//            print("statusCode should be 200, but is \(httpStatus.statusCode)")
//            print("response = \(response)")
//        }
//        
//        let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
//        print("responseString = \(responseString)")
//    }
//    task.resume()
//}

func sendRequest(method: String, url: String, form: String, handler: ((NSData?, NSURLResponse?, NSError?) -> Void)?){
    let url:NSURL = NSURL(string: url)!
    let session = NSURLSession.sharedSession()
    
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = method
    request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
    
    let paramString = form
    request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
    print(request)
    let task = session.dataTaskWithRequest(request, completionHandler: handler!)
    task.resume()
}

func convertStringToDictionary(text: String) -> [String:AnyObject]? {
    if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String:AnyObject]
            return json
        } catch {
            print("Something went wrong")
        }
    }
    return nil
}