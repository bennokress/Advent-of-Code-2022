//
// 💡 Advent of Code 2022 - Day 02
// 🎅🏽 Author: Benno Kress
//

import Foundation

public class Solver02 {
    
    /// Gameplan parsed from the input
    private var gameplan: [GameRound] = []
    
    init() { }
    
    func parseGamePlan(from input: String) {
        let inputEntries = input.components(separatedBy: .newlines)
        for entry in inputEntries {
            let gameRoundLetters = entry.components(separatedBy: .whitespaces)
            let opponentGesture = Gesture(letter: gameRoundLetters.first!)
            let playerGesture = Gesture(letter: gameRoundLetters.last!)
            let suggestedResult = GameRound.Result(letter: gameRoundLetters.last!)
            addRound(opponentGesture: opponentGesture, playerGesture: playerGesture, suggestedResult: suggestedResult, to: &gameplan)
        }
    }
    
    /// The player's score when making gestures according to the game plan
    var answer1: Int {
        gameplan.map(\.score).reduce(0, +)
    }
    
    /// The player's score when playing for the result suggested in the game plan
    var answer2: Int {
        gameplan.map(\.suggestedScore).reduce(0, +)
    }
    
    private func addRound(opponentGesture: Gesture, playerGesture: Gesture, suggestedResult: GameRound.Result, to gameplan: inout [GameRound]) {
        let round = GameRound(opponentGesture: opponentGesture, playerGesture: playerGesture, suggestedResult: suggestedResult)
        gameplan.append(round)
    }
    
}

extension Solver02: Solver {
    
    public func solve(using input: String) { parseGamePlan(from: input) }
    
    public var solutionPart1: String { String(answer1) }
    
    public var solutionPart2: String { String(answer2) }
    
}

extension Solver02: CustomStringConvertible {
    
    public var description: String {
        """
        \(descriptionTitle)
        
        The answer to part 1 is \(solutionPart1).
        The answer to part 2 is \(solutionPart2).
        
        The rounds are:
        \(gameRoundsDescription)
        """
    }
    
    private var descriptionTitle: String { "✼*✻*✼*✻* Day 02 *✻*✼*✻*✼" }
    private var gameRoundsDescription: String { gameplan.map(\.description).joined(separator: "\n") }
    
}

struct GameRound: CustomStringConvertible {
    
    let opponentGesture: Gesture
    
    // Challenge 1
    let playerGesture: Gesture
    var result: Result { Result(of: playerGesture, against: opponentGesture) }
    var score: Int { playerGesture.score + result.score }
    
    // Challenge 2
    let suggestedResult: Result
    var suggestedPlayerGesture: Gesture { Gesture(for: suggestedResult, against: opponentGesture) }
    var suggestedScore: Int { suggestedPlayerGesture.score + suggestedResult.score }
    
    var description: String {
        "\t• Game 1 - [\(score)] \(opponentGesture) vs. \(playerGesture) → \(result.description)"
        + "\n"
        + "\t• Game 2 - [\(score)] \(opponentGesture) vs. \(playerGesture) → \(result.description)"
    }
    
}

// MARK: - Supporting Types

extension GameRound {
    
    enum Result: Int, CustomStringConvertible {
        
        case loss = 0
        case draw = 3
        case win = 6
        
        init(of playerGesture: Gesture, against opponentGesture: Gesture) {
            switch (playerGesture, opponentGesture) {
            case (.rock, .paper), (.paper, .scissors), (.scissors, .rock): self = .loss
            case (.rock, .rock), (.paper, .paper), (.scissors, .scissors): self = .draw
            case (.paper, .rock), (.scissors, .paper), (.rock, .scissors): self = .win
            }
        }
        
        init(letter: String) {
            switch letter {
            case "X": self = .loss
            case "Y": self = .draw
            case "Z": self = .win
            default:
                fatalError()
            }
        }
        
        var score: Int { rawValue }
        
        var description: String {
            switch self { 
            case .loss: return "Opponent wins"
            case .draw: return "Draw"
            case .win: return "Player wins"
            }
        }
        
    }
    
}

enum Gesture: Int, CustomStringConvertible {
    
    case rock = 1
    case paper = 2
    case scissors = 3
    
    init(letter: String) {
        switch letter {
        case "A", "X": self = .rock
        case "B", "Y": self = .paper
        case "C", "Z": self = .scissors
        default:
            fatalError()
        }
    }
    
    init(for result: GameRound.Result, against opponentGesture: Gesture) {
        switch (opponentGesture, result) {
        case (.rock, .loss), (.scissors, .draw), (.paper, .win): self = .scissors
        case (.scissors, .loss), (.paper, .draw), (.rock, .win): self = .paper
        case (.paper, .loss), (.rock, .draw), (.scissors, .win): self = .rock
        }
    }
    
    var score: Int { rawValue }
    
    var description: String { 
        switch self {
        case .rock: return "Rock"
        case .paper: return "Paper"
        case .scissors: return "Scissors"
        }
    }
    
}
