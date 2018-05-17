//
//  Array+.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 5. 14..
//  Copyright © 2018년 JK. All rights reserved.
//

extension Array: JSON {
    
    func description() -> String {
        
        let (stringCount, booleanCount, numberCount, objectCount, arrayCount, totalCount) = calculationTypeCount()
        
         var descriptionValue = "총 \(totalCount) 개의 배열 데이터 중에 "
        
        if stringCount > 0 {
            descriptionValue += "문자열 \(stringCount)개 "
        }
        
        if numberCount > 0 {
            descriptionValue += "숫자 \(numberCount)개 "
        }
        
        if booleanCount > 0 {
            descriptionValue += "부울 \(booleanCount)개 "
        }
        
        if objectCount > 0 {
            descriptionValue += "객체 \(objectCount)개 "
        }
        
        if arrayCount > 0 {
            descriptionValue += "배열 \(arrayCount)개 "
        }
        
        return descriptionValue + "가 포함되어 있습니다."
    }
    
    func calculationTypeCount() -> (Int, Int, Int, Int, Int, Int) {
        var totalCount = 0
        var stringOfCount = 0
        var booleaOfnCount = 0
        var numberOfCount = 0
        var objectOfCount = 0
        var arrayOfCount = 0
        
        for type in convertTypeArray(converterType()) {
            totalCount += 1
            switch type {
                case .string(_):
                    stringOfCount += 1
                case .bool(_):
                    booleaOfnCount += 1
                case .number(_):
                    numberOfCount += 1
                case .object(_):
                    objectOfCount += 1
                case .array(_):
                    arrayOfCount += 1
            }
        }
        return (stringOfCount, booleaOfnCount, numberOfCount, objectOfCount, arrayOfCount, totalCount)
    }
    
    func jsonFormMaker() -> String {
        return arratFormMaker(convertTypeArray(converterType()))
    }
    
    private func converterType() -> Type {
        return self[0] as! Type
    }
    
    private func convertTypeArray(_ type: Type) -> [Type] {
        return type.array!
    }
    
    private func arratFormMaker(_ a: [Type]) -> String {
        var desciption = "\(TokenForm.openBracket.str)\n"
        
        for element in a {
            desciption += "\t"
            switch element {
                case .string(let s):
                    desciption += s
                case .bool(let b):
                    desciption += String(b)
                case .number(let n):
                    desciption += String(n)
                case .array(let a):
                    desciption += arratFormMaker(a)
                case .object(let o):
                    desciption += objectFormMaker(o)
            }
               desciption += "\n"
        }
        
        desciption += "\(TokenForm.closeBracket.str)"
        return desciption
    }
    
    private func objectFormMaker(_ o: [String: Type]) -> String {
        var desription = "\(TokenForm.openBrace.str)\t"
        
        for key in o.keys {
            let value = o[key]!
            switch value {
                case .number(let n):
                    let value = key + "\t" + TokenForm.colon.str + "\t" + String(n)
                    desription += value
                case .string(let s):
                    let value = key + "\t" + TokenForm.colon.str + "\t" + s
                    desription = value
                case .bool(let b):
                    let value = key + "\t" + TokenForm.colon.str + "\t"  + String(b)
                    desription = value
                case .object(let o):
                    desription += objectFormMaker(o)
                case .array(let a):
                    desription += arratFormMaker(a)
                }
                desription += "\t\(TokenForm.closeBrace.str)"
        }
        return desription
    }
}
