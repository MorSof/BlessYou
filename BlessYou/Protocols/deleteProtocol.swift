//
//  deleteProtocol.swift
//  BlessYou
//
//  Created by Mor Soferian on 7/10/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import Foundation

protocol DeleteProtocol {
    
    func onSubscriptionDeleteSuccess()

    func onFailureDelete(error: Error?)
}
