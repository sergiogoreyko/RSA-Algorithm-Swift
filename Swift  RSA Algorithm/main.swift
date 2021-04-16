//
//  main.swift
//  Swift  RSA Algorithm
//
//  Created by Сергей Горейко on 14/04/2020.
//  Copyright © 2020 Сергей Горейко. All rights reserved.
//

import Foundation

class RSA {
    
    var p: Int = 0
    var q: Int = 0
    
    init() {}
    
    var m: Int {
        return p * q
    }
    
    var t: Int {
        return ( p - 1 ) * ( q - 1 )
    }
    
    var e: Int {
        for i in 2..<t {
            if greatestCommonDivisor(i, t) == 1 {
                return i
            }
        }
        
        return -1
    }
    
    var d: Int {
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
}


extension RSA {
    
    func isPrime(_ prime: Int) -> Bool {
        
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
    
    func modExp(_ base: Int, _ index_n: Int, _ modulus: Int) -> Int {
        
        var c = 1
        for _ in 1...index_n {
            c = (c * base) % modulus
        }
        return c
    }
    
    func encrypt() {
        
        print("\nInsert the message to encode:")
        
        let num = Int(readLine()!)!
        let res = modExp(num, e, m)
        
        print("\nRESULT: \(res)")
    }

    func decrypt() {
        
        print("\nInsert the message to decode:")
        
        let num = Int(readLine()!)!
        let res = modExp(num, d, m)
        
        print("\nRESULT: \(res)")
    }
    
    func buildRSA() {
        
        print("Welcome to RSA program\n")
        
        // 1. Choose two different random primes p and q.
        
        repeat {
                
            print("Enter a Prime number  p :")
                    
            p = Int(readLine()!)!
                    
            if !isPrime(p) {
                        
                print("\nWRONG INPUT (This number is not Prime. A prime number is a natural number greater than 1 that has no positive divisors other than 1 and itself)\n")
            }
                    
        } while !isPrime(p)
        
        repeat {
                
            print("Enter a Prime number  q :")
                    
            q = Int(readLine()!)!
                    
            if !isPrime(q) {
                        
                print("\nWRONG INPUT (This number is not Prime. A prime number is a natural number greater than 1 that has no positive divisors other than 1 and itself)\n")
            }
                    
        } while !isPrime(q)
        
        // 2. Calculate their multiplication m = p ⋅ q, which is called the module.
        
        print("\nResult of computing n = p*q = \(m)")
        
        // 3. Calculate the value of the Euler's function: φ(m) = t = (p−1)⋅(q−1).
        
        print("Result of computing Euler's function: t = \(t)")
        
        // 4. Choose an integer e ( 1 < e < φ(m) ), coprime to t, called the open exponent.

        print("Result of computing e = \(e)")
            
        // 5. Calculate the number d that is multiplicatively inverse to the number e modulo φ(m), that is, a number satisfying the equation:
        //    d ⋅ e ≡ 1 (mod φ(m)).

        print("Result of computing d = \(d)")
            
        // 6. The pair {m, e} is published as an RSA public key.
        
        print("\nRSA public key is (m = \(m)), (e = \(e))")

        // 7. The pair {m, d} plays the role of the RSA private key and is kept secret.
        
        print("RSA private key is (m = \(m)), (d = \(d))\n")
    }
    
    func chooseCommand() {

        print("Choose command:\n1. Encrypt\n2. Decrypt\n-------------------")

        let v = Int(readLine()!)!
        switch v {
            case 1:
                self.encrypt()
            case 2:
                self.decrypt()
            default:
                print("Error")
        }
    }
}


let rsa = RSA()
rsa.buildRSA()
rsa.chooseCommand()


