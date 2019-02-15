//
//  w6d5_ui_performance_testingUITests.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by Yilei Huang on 2019-02-15.
//  Copyright © 2019 Roland. All rights reserved.
//

import XCTest


class w6d5_ui_performance_testingUITests: XCTestCase {
    var app:XCUIApplication!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
       app = XCUIApplication()
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func addNetMeal(mealName:String, numberOfCalories: Int){
        
        app.navigationBars["Master"].buttons["Add"].tap()
        
        let addAMealAlert = app.alerts["Add a Meal"]
        let collectionViewsQuery = addAMealAlert.collectionViews
        collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText(mealName)
        
        let textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.typeText("\(numberOfCalories)")
        addAMealAlert.buttons["Ok"].tap()
    }
    
    func deleteMeal(mealName:String, numberOfCalories:Int){
        let staticText = app.tables.staticTexts["\(mealName) - \(numberOfCalories)"]
        if staticText.exists{
             staticText.swipeLeft()
            app.tables.buttons["Delete"].tap()
        }
       
    }
    func testDeleteAll(){
        //let allTableItem = app.tables.count
        guard app.tables.count > 0 else{
            return
        }
        let base = app.tables.staticTexts.count
        for _ in 0..<base{
            app.tables.staticTexts.element(boundBy: 0).swipeLeft()
            //print(item)
           
            if (app.tables.buttons["Delete"].exists){
                app.tables.buttons["Delete"].tap()
            }
            
    
        }
    }
    func testDeleteMeal(){
        deleteMeal(mealName: "Burger", numberOfCalories: 300)
    }
    func testShowMealDetail(){
        let staticText = app.tables.staticTexts["Burger - 300"]
        staticText.tap()
        let detailText = app.staticTexts["ggLabel"]
        //print(detailText.label)
        XCTAssertEqual(detailText.label, "Burger - 300")
        app.navigationBars["Detail"].buttons["Master"].tap()
        
    }
    func testPerformance(){
        self.measure {
            //startMeasuring()
            addNetMeal(mealName: "Burger1", numberOfCalories: 300)
            deleteMeal(mealName: "Burger1", numberOfCalories: 300)
            
            //stopMeasuring()
        }
  
        
      
        
    }
    func testAddMeal() {
    
        addNetMeal(mealName: "Burger", numberOfCalories: 300)
        addNetMeal(mealName: "Burger", numberOfCalories: 300)
        addNetMeal(mealName: "Burger", numberOfCalories: 300)
        addNetMeal(mealName: "Burger", numberOfCalories: 300)

      
        
     
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
