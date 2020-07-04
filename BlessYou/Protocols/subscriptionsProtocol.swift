//
//  subscriptionsProtocol.swift
//  BlessYou
//
//  Created by Mor Soferian on 7/4/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import Foundation

protocol SubscriptionsProtocol {
    
    //Signup call backs
    func onFetchedSubscriptionsSuccess(subscriptions: Array<BirthdayDetails>)
        
    func onFailure(error: Error?)
    
}
