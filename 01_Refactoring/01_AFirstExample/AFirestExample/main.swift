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
    var price : Price
    
//    init(title: String, priceCode: PriceCode) {
//        self.title = title
//        self.priceCode = priceCode
//    }
    
    init(title: String, price: Price) {
        self.title = title
        self.price = price
    }
    
    func charge(for daysRented: Int) -> Float{
        return price.charge(for:daysRented)
    }
    
    func frequentRenterPoint(for daysRented: Int) -> Int{
        return 1
    }
}


class Price{
    func charge(for daysRented: Int) -> Float {
        return 0.0
    }
}

class RegularPrice: Price{
    override func charge(for daysRented: Int) -> Float {
        var result: Float = 0.0
        result += 2.0
        if daysRented > 2{
            result += Float(daysRented - 2) * 1.5
        }
        return result
    }
}


class ChildrenPrice: Price {
    override func charge(for daysRented: Int) -> Float {
        var result: Float = 0.0
        result += 1.5
        if daysRented > 3{
            result += Float(daysRented - 3) * 1.5
        }
        return result
    }
}

class NewReleasePrice: Price {
    override func charge(for daysRented: Int) -> Float {
        var result: Float = 0.0
        result += Float(daysRented) * 3
        return result
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
        return movie.charge(for: daysRented)
    }
    
    func frequentRenterPoint() -> Int{
        return movie.frequentRenterPoint(for: daysRented)
    }
}

class Statement{
    func value(of customer: Customer) -> String{
        return ""
    }
}

class TextStatement: Statement{
    override func value(of customer: Customer) -> String {
        var result = "Rental Record for \(customer.name)  \n"
        
        for (_, rental) in customer.rentals.enumerated(){
            //show figures for this rental
            result += "\t \(rental.movie.title) \t \(rental.charge()) \n"
        }
        
        //add footer lines
        result += "Amount owned is \(customer.totalAmount()) \n"
        result += "Your earned \(customer.totalFrequentRenterPoint()) frequent renter points"
        
        return result
    }
}

class HtmlStatement: Statement{
    override func value(of customer: Customer) -> String {
        var result = "<h1>Rental Record for \(customer.name)  </h1>"
        
        for (_, rental) in customer.rentals.enumerated(){
            //show figures for this rental
            result += "<p> \(rental.movie.title) \t \(rental.charge()) </p>"
        }
        
        //add footer lines
        result += "<p> Amount owned is \(customer.totalAmount()) </p>"
        result += "</p> Your earned <EM> \(customer.totalFrequentRenterPoint()) <EM> frequent renter points </p>"
        
        return result
    }
}

class Customer{
    var name: String
    var rentals =  [Rental]()
    var statement: Statement
    
    init(name: String, statement: Statement) {
        self.name = name
        self.statement = statement
    }
    
    public func addRental(_ rental: Rental){
        rentals.append(rental)
    }
    
    
    func output() -> String{
        return statement.value(of: self)
    }
    
    
    func totalAmount() -> Float {        
        return rentals.reduce(0, { (result, rental) -> Float in
            result + rental.charge()
        })
    }
    
    func totalFrequentRenterPoint() -> Int {
        return rentals.reduce(0, { (result, rental) -> Int in
            result + rental.frequentRenterPoint()
        })
    }
}


let movie1 = Movie.init(title: "肖申克的救赎", price: RegularPrice.init())
let movie2 = Movie.init(title: "狮子王", price: ChildrenPrice.init())
let movie3 = Movie.init(title: "生活万岁", price: NewReleasePrice.init())

let rental1 = Rental.init(movie: movie1, daysRented: 2)
let rental2 = Rental.init(movie: movie2, daysRented: 1)
let rental3 = Rental.init(movie: movie3, daysRented: 3)

let customer = Customer.init(name: "lanjing", statement: HtmlStatement.init())
customer.addRental(rental1)
customer.addRental(rental2)
customer.addRental(rental3)

print(customer.output())

//print("Hello, World!")

