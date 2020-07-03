//
//  signInProtocol.swift
//  BlessYou
//
//  Created by Mor Soferian on 7/3/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import Foundation

protocol SignInProtocol {
    
    //Signup call backs
    func onFetchedBirthdaysSuccess(birthdaysArr: Array<BirthdayDetails>)
        
    func onFailure(error: Error?)
}
