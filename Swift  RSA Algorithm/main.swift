//
//  main.swift
//  Swift  RSA Algorithm
//
//  Created by Сергей Горейко on 14/04/2020.
//  Copyright © 2020 Сергей Горейко. All rights reserved.
//

import Foundation

var p, q, t: Int

var m = 0
var e = 0
var d = 0

var flag: Bool
var num: Int = 0
var res: Int = 0


func isPrime(prime: Int) -> Bool {
    
    let j = Int(sqrt(Double(prime)))
    
    for i in 2...j {
        if prime.isMultiple(of: i) {
            return false
        }
    }
    
    return true
}

func greatestCommonDivisor(_ x: Int, _ y: Int ) -> Int {
    
    var x1 = x
    var y1 = y
    
    while x1 > 0 {
        
        var myTemp: Int
        
        myTemp = x1
        x1 = y1 % x1
        y1 = myTemp
    }
    
    return y1
}

func calculateE(_ t: Int ) -> Int {

    // Выбирается целое число e ( 1 < e < t ) // взаимно простое со значением функции Эйлера (t)

    for i in 2..<t {
        if (greatestCommonDivisor(i, t) == 1 ) {
            return i
        }
    }
    
    return -1
}

func calculateD(_ e: Int, _ t: Int) -> Int {
    
    // Вычисляется число d, мультипликативно обратное к числу e по модулю φ(m), то есть число, удовлетворяющее уравнению:
    //    d ⋅ e ≡ 1 (mod φ(m))
    
    var d: Int
    var k: Int = 1
    
    while true {
        k += t
        
        if k.isMultiple(of: e) {
            d = k / e
            return d
        }
    }
}

func modexp(_ base: Int, _ index_n: Int, _ modulus: Int) -> Int {
    
    var c = 1
    for _ in 1...index_n {
        c = (c * base) % modulus
    }
    return c
}

func encrypt() {
    
    print("\nInsert the message to encode:")
    
    num = Int(readLine()!)!
    res = modexp(num, e, m)
    
    print("\nRESULT: \(res)")
}

func decrypt() {
    
    print("\nInsert the message to decode:")
    
    num = Int(readLine()!)!
    res = modexp(num, d, m)
    
    print("\nRESULT: \(res)")
}

print("Welcome to RSA program\n")
    
// Cоздание открытого и секретного ключей
    
// 1. Выбираются два различных случайных простых числа p и q
    
repeat {
    
    print("Enter a Prime number  p :")
        
    p = Int(readLine()!)!
    flag = isPrime(prime: p)
        
    if !flag {
            
        print("\nWRONG INPUT (This number is not Prime. A prime number is a natural number greater than 1 that has no positive divisors other than 1 and itself)\n")
    }
        
} while !flag

repeat {
    
    print("Enter a Prime number  q :")
        
    q = Int(readLine()!)!
    flag = isPrime(prime: q)
        
    if !flag {
            
        print("\nWRONG INPUT (This number is not Prime. A prime number is a natural number greater than 1 that has no positive divisors other than 1 and itself)\n")
    }
        
} while !flag
    
// 2. Вычисляется их произведение m = p ⋅ q, которое называется модулем.

m = p * q
print("\nResult of computing n = p*q = \(m)")
    
// 3. Вычисляется значение функции Эйлера от числа m: φ(m) = t = (p−1)⋅(q−1)

t = ( p - 1 ) * ( q - 1 )
print("Result of computing Euler's totient function: t = \(t)")
    
// 4. Выбирается целое число e ( 1 < e < φ(m) ), взаимно простое с t
//      Число e называется открытой экспонентой

e = calculateE(t)
    
// 5. Вычисляется число d, мультипликативно обратное к числу e по модулю φ(m), то есть число, удовлетворяющее уравнению:
//    d ⋅ e ≡ 1 (mod φ(m))

d = calculateD(e, t)
    
// 6. Пара {m, e} публикуется в качестве открытого ключа RSA

print("\nRSA public key is (m = \(m)), (e = \(e))")
    
// 7. Пара {m, d} играет роль закрытого ключа RSA и держится в секрете

print("RSA private key is (m = \(m)), (d = \(d))\n")

var v: Int
print("Choose command:\n1. Encrypt\n2. Decrypt")
print("------------------- ")

v = Int(readLine()!)!
switch v {
    case 1:
        encrypt()
    case 2:
        decrypt()
    default:
        print("Error")
}


