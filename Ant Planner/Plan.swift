//
//  Plan.swift
//  Ant Planner
//
//  Created by Desperado on 7/4/28 H.
//  Copyright © 28 Heisei Ant Inc. All rights reserved.
//

import Foundation

class Plan {
    let id: Int
    let ownerId: Int
    let name: String
    let description: String
    let importance: Int
    let tag: String
    let due: String
    let rep: String
    let phoneAlarm: Bool
    let phonePush: Bool
    let desktopPush: Bool
    let url: String
    let location: String
    let lat: Double
    let lng: Double
    
    init(id: Int, ownerId: Int, name: String, description: String, importance: Int, tag: String, due: String, rep: String, phoneAlarm: Bool, phonePush: Bool, desktopPush: Bool, url: String, location: String, lat: Double, lng: Double) {
        self.id = id
        self.ownerId = ownerId
        self.name = name
        self.description = description
        self.importance = importance
        self.tag = tag
        self.due = due
        self.rep = rep
        self.phoneAlarm = phoneAlarm
        self.phonePush = phonePush
        self.desktopPush = desktopPush
        self.url = url
        self.location = location
        self.lat = lat
        self.lng = lng
    }
}