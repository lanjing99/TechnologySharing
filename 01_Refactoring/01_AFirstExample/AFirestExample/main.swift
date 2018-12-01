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
//    var priceCode : PriceCode
    
//    init(title: String, priceCode: PriceCode) {
//        self.title = title
//        self.priceCode = priceCode
//    }
    
    init(title: String) {
        self.title = title
    }
    
    func charge(for daysRented: Int) -> Float{
        return 0.0
    }
    
    func frequentRenterPoint(for daysRented: Int) -> Int{
        return 1
    }
}

class RegularMovie: Movie{
    override func charge(for daysRented: Int) -> Float {
        var result: Float = 0.0
        result += 2.0
        if daysRented > 2{
            result += Float(daysRented - 2) * 1.5
        }
        return result
    }
}

class ChildrenMovie: Movie {
    override func charge(for daysRented: Int) -> Float {
        var result: Float = 0.0
        result += 1.5
        if daysRented > 3{
            result += Float(daysRented - 3) * 1.5
        }
        return result
    }
}

class NewReleaseMovie: Movie {
    override func charge(for daysRented: Int) -> Float {
        var result: Float = 0.0
        result += Float(daysRented) * 3
        return result
    }
    
    override func frequentRenterPoint(for daysRented: Int) -> Int {
        var frequentRenterPoint = 1
        if  daysRented > 1 {
            frequentRenterPoint += 1
        }
        return frequentRenterPoint
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

        
        var result = "Rental Record for \(name)  \n"
        
        for (_, rental) in rentals.enumerated(){
            //show figures for this rental
            result += "\t \(rental.movie.title) \t \(rental.charge()) \n"
        }
        
        //add footer lines
        result += "Amount owned is \(totalAmount()) \n"
        result += "Your earned \(totalFrequentRenterPoint()) frequent renter points"
        
        return result
    }
    
    
    //添加一个HTML的格式输出
    func htmlStatement() -> String{
        return ""
    }
    
    
    func totalAmount() -> Float {
//        var result:Float = 0.0
//        for (_, rental) in rentals.enumerated(){
//            result += rental.charge()
//        }
//        return result
        
        return rentals.reduce(0, { (result, rental) -> Float in
            result + rental.charge()
        })
    }
    
    func totalFrequentRenterPoint() -> Int {
//        var result:Int = 0
//        for (_, rental) in rentals.enumerated(){
//            result += rental.frequentRenterPoint()
//        }
//        return result
        return rentals.reduce(0, { (result, rental) -> Int in
            result + rental.frequentRenterPoint()
        })
    }
}


let movie1 = RegularMovie.init(title: "肖申克的救赎")
let movie2 = ChildrenMovie.init(title: "狮子王")
let movie3 = NewReleaseMovie.init(title: "生活万岁")

let rental1 = Rental.init(movie: movie1, daysRented: 2)
let rental2 = Rental.init(movie: movie2, daysRented: 1)
let rental3 = Rental.init(movie: movie3, daysRented: 3)

let customer = Customer.init(name: "lanjing")
customer.addRental(rental1)
customer.addRental(rental2)
customer.addRental(rental3)

print(customer.statement())

//print("Hello, World!")

