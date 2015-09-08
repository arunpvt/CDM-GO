//
//  ServiceResponse.swift
//  CDM Go Admin
//
//  Created by Developer on 05/09/15.
//  Copyright (c) 2015 Developer. All rights reserved.
//

import Foundation


class ServiceResponse: NSObject{
    
//    @property (nonatomic, assign) BOOL status;
//    @property (nonatomic, strong) id output;
//    @property (nonatomic, copy) NSArray * errors;
//    
//    - (id)initWithStatus:(NSInteger)status output:(id)output errors:(NSArray *)errors;
    
    var status: Bool
    var output: AnyObject?
    var errors: NSArray?
    
    init(status: Bool, opt: AnyObject?, err: NSArray?){
        self.status = status
        self.output = opt
        self.errors = err
    }
    

}