//
//  UTFMock.swift
//  TestProject
//
//  Created by Sean Henry on 19/09/2018.
//  Copyright © 2018 Sean Henry. All rights reserved.
//

class UTFMock: UTF {
    var invokedUtfCount4 = false
    var invokedUtfCount4Count = 0
    func utfCount4💐() {
        invokedUtfCount4 = true
        invokedUtfCount4Count += 1
    }
}
