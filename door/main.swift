//: Playground - noun: a place where people can play

import Foundation

func random(numberOfChoices: Int) -> Int {
    return Int(arc4random_uniform(UInt32(numberOfChoices)))
}

func game(strategy: (Int, Int) -> Int) -> Bool {
    let prizeDoor = random(numberOfChoices: 3)
    let firstChoice = random(numberOfChoices: 3)
    var doorsWithoutPrize = [0, 1, 2]
    doorsWithoutPrize.remove(at: prizeDoor)
    if let firstChosenIndex = doorsWithoutPrize.index(of: firstChoice) {
        doorsWithoutPrize.remove(at: firstChosenIndex)
    }
    let revealedDoor: Int
    if doorsWithoutPrize.count > 1 {
        revealedDoor = doorsWithoutPrize[random(numberOfChoices: 2)]
    } else {
        revealedDoor = doorsWithoutPrize.first!
    }
    let secondChoice = strategy(firstChoice, revealedDoor)
    return secondChoice == prizeDoor
}

func stayStrategy(firstChoice: Int, revealedDoor: Int) -> Int {
    return firstChoice
}

func randomSecondChoiceStrategy(firstChoice: Int, revealedDoor: Int) -> Int {
    var doorsRemaining = [0, 1, 2]
    doorsRemaining.remove(at: revealedDoor)
    return doorsRemaining[random(numberOfChoices: 2)]
}

func switchStrategy(firstChoice: Int, revealedDoor: Int) -> Int {
    var doorsRemaining = [0, 1, 2]
    doorsRemaining.remove(at: revealedDoor)
    if let firstChoiceIndex = doorsRemaining.index(of: firstChoice) {
        doorsRemaining.remove(at: firstChoiceIndex)
    }
    assert(doorsRemaining.count == 1)
    return doorsRemaining.first!
}

var wins = [0, 0, 0]
for _ in 0..<100000 {
    if game(strategy: stayStrategy) {
        wins[0] += 1
    }
    if game(strategy: randomSecondChoiceStrategy) {
        wins[1] += 1
    }
    if game(strategy: switchStrategy) {
        wins[2] += 1
    }
}

print(wins)
