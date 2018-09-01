//
//  Fibonnacci.swift
//  CupertinoStandards
//
//  Created by Jorge Luis on 17/08/18.
//

import Foundation

public class CSMathUtils {
    
    
    // Fibonacci series
    // F[n] = F[n-1] + F[n-2]
    // 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144
    // Find the fibonacci number for n interations
    public static func fibonacci(n: Int, includeFirstZeroAndOne: Bool = false) -> [Int] {
        var result: [Int] = []
        var num1 = 0
        var num2 = 1
        
        if includeFirstZeroAndOne {
            result.append(contentsOf: [num1,num2])
        }
        
        for _ in 0 ... n {
            
            let num = num1 + num2
            num1 = num2
            num2 = num
            result.append(num)
            
        }
        
        return result
    }
}
