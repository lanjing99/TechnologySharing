//
//  *@项目名称:  AFirestExample
//  *@文件名称:  main.swift
//  *@Date 2018/12/1
//  *@Author lanjing 
//  *@Copyright © :  2014-2018 X-Financial Inc.   All rights reserved.
//  *注意：本内容仅限于小赢科技有限责任公内部传阅，禁止外泄以及用于其他的商业目的。
//

import Foundation

enum PriceCode{
    case CHILDRENS
    case REGULAR
    case NEW_RELEASE
}

class Movie{
    var title: String
    var priceCode : PriceCode
    
    init(title: String, priceCode: PriceCode) {
        self.title = title
        self.priceCode = priceCode
    }
}

class Rental{
    var movie: Movie
    var daysRented: Int
    
    init(movie: Movie, daysRented: Int) {
        self.movie = movie
        self.daysRented = daysRented
    }
}

class Customer{
    private var name: String
    private var rentals =  [Rental]()
    
    init(name: String) {
        self.name = name
    }
    
    public func addRental(_ rental: Rental){
        rentals.append(rental)
    }
    
    
    func statement() -> String{
        var totalAmount:Float = 0.0
        var frequentRenterPoint = 0
        
        var result = "Rental Record for \(name)  \n"
        
        for (_, rental) in rentals.enumerated(){
            var thisAmount: Float = 0.0
            
            switch rental.movie.priceCode {
            case .REGULAR:
                thisAmount += 2.0
                if rental.daysRented > 2{
                    thisAmount += Float(rental.daysRented - 2) * 1.5
                }
                
            case .NEW_RELEASE:
                thisAmount += Float(rental.daysRented) * 3
                
            case .CHILDRENS:
                thisAmount += 1.5
                if rental.daysRented > 3{
                    thisAmount += Float(rental.daysRented - 3) * 1.5
                }
            }
            
            frequentRenterPoint += 1
            if rental.movie.priceCode == .NEW_RELEASE && rental.daysRented > 1 {
                frequentRenterPoint += 1
            }
            
            result += "\t \(rental.movie.title) \t \(thisAmount) \n"
            totalAmount += thisAmount
        }
        
        
        
        return result
    }
}


let movie1 = Movie.init(title: "肖申克的救赎", priceCode: .REGULAR)
let movie2 = Movie.init(title: "狮子王", priceCode: .CHILDRENS)
let movie3 = Movie.init(title: "生活万岁", priceCode: .NEW_RELEASE)

let rental1 = Rental.init(movie: movie1, daysRented: 2)
let rental2 = Rental.init(movie: movie2, daysRented: 1)
let rental3 = Rental.init(movie: movie3, daysRented: 3)

let customer = Customer.init(name: "lanjing")
customer.addRental(rental1)
customer.addRental(rental2)
customer.addRental(rental2)

print(customer.statement())

//print("Hello, World!")

