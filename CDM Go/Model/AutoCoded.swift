//
//  AutoCoded.swift
//  CDM Go
//
//  Created by Developer on 04/09/15.
//  Copyright (c) 2015 OFS. All rights reserved.
//

import UIKit

class AutoCoded: NSCoder {
    class AutoCoded: NSObject, NSCoding {
        
        private let AutoCodingKey = "autoEncodings"
        
        override init() {
            super.init()
        }
        
        required init(coder aDecoder: NSCoder) {
            
            super.init()
            
            let decodings = aDecoder.decodeObjectForKey(AutoCodingKey) as! [String]
            setValue(decodings, forKey: AutoCodingKey)
            
            for decoding in decodings {
                setValue(aDecoder.decodeObjectForKey(decoding), forKey: decoding)
            }
            
            
        }
        func encodeWithCoder(aCoder: NSCoder) {
            
            aCoder.encodeObject(valueForKey(AutoCodingKey), forKey: AutoCodingKey)
            
            for encoding in valueForKey(AutoCodingKey) as! [String] {
                aCoder.encodeObject(valueForKey(encoding), forKey: encoding)
            }
        }
    }
}
