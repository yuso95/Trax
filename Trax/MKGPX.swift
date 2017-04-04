//
//  MKGPX.swift
//  Trax
//
//  Created by Younoussa Ousmane Abdou on 4/3/17.
//  Copyright © 2017 Younoussa Ousmane Abdou. All rights reserved.
//

import MapKit

extension GPX.Waypoint: MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var title: String? { return name }
    
    var subtitle: String? { return info }
    
    var thumbnailURL: NSURL? {
        
        return getImageofURLofType(type: "thumbnail")
    }
    
    var imageURL: NSURL? {
        
        return getImageofURLofType(type: "large")
    }
    
    private func getImageofURLofType(type: String?) -> NSURL? {
        
        for link in links {
            if link.type == type {
                
                return link.url as NSURL?
            }
        }
        
        return nil
    }
}
