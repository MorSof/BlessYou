//
//  blessProtocol.swift
//  BlessYou
//
//  Created by Mor Soferian on 7/4/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import Foundation

protocol BlessProtocol {
    
    //Signup call backs
    func onFetchedWishesSuccess(wishes: Array<String>)
        
    func onFailure(error: Error?)
}
