//
//  InputMenu.swift
//  JSONParser
//
//  Created by 윤동민 on 21/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

// 사용자가 입력할 수 있는 데이터 타입 Ex) 배열, 객체
protocol JSONType {
    func conutType() -> (Int, Int, Int, Int, Int, Int)
    func printTotalText(_ totalCount : Int) -> String
}

