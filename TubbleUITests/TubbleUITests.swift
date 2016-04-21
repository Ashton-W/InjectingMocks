import XCTest

class TubbleUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments += ["--enableStubs"]
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        
        let app = XCUIApplication()
        app.navigationBars["Posts"].staticTexts["Posts"].exists
        app.tables.cells.staticTexts["qui est esse"].exists
        
        sleep(10) // just for the demo
    }
    
}
