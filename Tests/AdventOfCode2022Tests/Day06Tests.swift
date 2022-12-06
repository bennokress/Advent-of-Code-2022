import XCTest
@testable import AdventOfCode2022

final class Day06ATests: XCTestCase {
    
    let input = """
        mjqjpqmgbljsphdztnvjfqwrcgsmlb
        """
    
    func testExample() throws {
        let solver = Solver06()
        solver.solve(using: input)
        
        XCTAssertEqual(solver.answer1, 7)
        XCTAssertEqual(solver.answer2, 19)
    }
    
}

final class Day06BTests: XCTestCase {
    
    let input = """
        bvwbjplbgvbhsrlpgdmjqwftvncz
        """
    
    func testExample() throws {
        let solver = Solver06()
        solver.solve(using: input)
        
        XCTAssertEqual(solver.answer1, 5)
        XCTAssertEqual(solver.answer2, 23)
    }
    
}

final class Day06CTests: XCTestCase {
    
    let input = """
        nppdvjthqldpwncqszvftbrmjlhg
        """
    
    func testExample() throws {
        let solver = Solver06()
        solver.solve(using: input)
        
        XCTAssertEqual(solver.answer1, 6)
        XCTAssertEqual(solver.answer2, 23)
    }
    
}

final class Day06DTests: XCTestCase {
    
    let input = """
        nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg
        """
    
    func testExample() throws {
        let solver = Solver06()
        solver.solve(using: input)
        
        XCTAssertEqual(solver.answer1, 10)
        XCTAssertEqual(solver.answer2, 29)
    }
    
}

final class Day06ETests: XCTestCase {
    
    let input = """
        zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw
        """
    
    func testExample() throws {
        let solver = Solver06()
        solver.solve(using: input)
        
        XCTAssertEqual(solver.answer1, 11)
        XCTAssertEqual(solver.answer2, 26)
    }
    
}
