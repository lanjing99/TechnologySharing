//
//  *@项目名称:  AFirestExample
//  *@文件名称:  main.swift
//  *@Date 2018/12/1
//  *@Author lanjing
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
    
    func charge() -> Float{
        var result: Float = 0.0
        
        switch movie.priceCode {
        case .REGULAR:
            result += 2.0
            if daysRented > 2{
                result += Float(daysRented - 2) * 1.5
            }
            
        case .NEW_RELEASE:
            result += Float(daysRented) * 3
            
        case .CHILDRENS:
            result += 1.5
            if daysRented > 3{
                result += Float(daysRented - 3) * 1.5
            }
        }
        return result
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
 
            //add frequent renter points
            frequentRenterPoint += 1
            if rental.movie.priceCode == .NEW_RELEASE && rental.daysRented > 1 {
                frequentRenterPoint += 1
            }
            
            //show figures for this rental
            result += "\t \(rental.movie.title) \t \(rental.charge()) \n"
            totalAmount += rental.charge()
        }
        
        //add footer lines
        result += "Amount owned is \(totalAmount) \n"
        result += "Your earned \(frequentRenterPoint) frequent renter points"
        
        return result
    }
    
    
    //添加一个HTML的格式输出
    func htmlStatement() -> String{
        return ""
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
customer.addRental(rental3)

print(customer.statement())

//print("Hello, World!")

