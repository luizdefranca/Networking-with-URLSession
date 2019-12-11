//
//  ViewController.swift
//  ConcurrencyTest
//
//  Created by Luiz on 12/10/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var primeNumberButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculatePrimeNumber(_ sender: UIButton) {
        for number in 0 ... 100_000_000 {
            let isPrimeNumber = isPrime(number: number)
            print("\(number) is prime: \(isPrimeNumber)")
        }
    }

    func isPrime(number: Int) -> Bool{
        if number <= 1 {
            return false
        }

        if number <= 3 {
            return true
        }

        var i = 2
        while i*i <= number {
            if number % i == 0 {
                return false
            }
            i = i + 1
        }
        return true
    }
}

