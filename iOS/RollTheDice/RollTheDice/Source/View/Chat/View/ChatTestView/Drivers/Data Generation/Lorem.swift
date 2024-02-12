//
//  Lorem.swift
//  RollTheDice
//
//  Created by 신예진 on 2/12/24.
//

import Foundation

public class Lorem {
    private static let wordList = [
        "안녕하세요", "반갑습니다", "감사합니다", "좋아요", "즐거워요",
        "행복합니다", "축하합니다", "화이팅", "잘가요", "다시 만나요",
        "사랑해요", "고마워요", "미안해요", "죄송합니다", "기쁘다",
        "슬퍼요", "화나요", "힘내세요", "힘들어요", "좋은 하루 되세요",
        "행운을 빕니다", "꿈을 이루세요", "건강하세요", "열심히 해봐요",
        "맛있게 드세요", "즐거운 시간 보내세요", "잘 자요", "좋은 꿈 꾸세요",
        "포기하지 마세요", "열심히 할게요", "맛있는 음식", "아름다운 자연",
        "행복한 가정", "좋은 친구", "따뜻한 마음", "즐거운 여행", "힐링타임",
        "재미있는 취미", "새로운 시작", "행복한 미래", "자유로운 삶", "평화로운 마음"
    ]
    
    private static var markdownSymbols = ["*", "_", "**", "**"]
    
    /**
     Return a random word.
     
     - returns: Returns a random word.
     */
    public class func word() -> String {
        return wordList.random()!
    }
    
    /**
     Return an array of `count` words.
     
     - parameter count: The number of words to return.
     
     - returns: Returns an array of `count` words.
     */
    public class func words(nbWords: Int = 3) -> [String] {
        return wordList.random(nbWords)
    }
    
    /**
     Return a string of `count` words.
     
     - parameter count: The number of words the string should contain.
     
     - returns: Returns a string of `count` words.
     */
    public class func words(nbWords: Int = 3, useMarkdown: Bool = false) -> String {
        words(nbWords: nbWords)
            .map {
                guard useMarkdown, Int.random(min: 0, max: 10) == 0 else {
                    return $0
                }
                let symbol = markdownSymbols.random()!
                return symbol + $0 + symbol
            }
            .joined(separator: " ")
    }
    
    /**
     Generate a sentence of `nbWords` words.
     - parameter nbWords:  The number of words the sentence should contain.
     - parameter variable: If `true`, the number of words will vary between
     +/- 40% of `nbWords`.
     - returns:
     */
    public class func sentence(nbWords: Int = 6, variable: Bool = true, useMarkdown: Bool = false) -> String {
        if nbWords <= 0 {
            return ""
        }
        
        let result: String = words(
            nbWords: variable ? nbWords.randomize(variation: 40) : nbWords,
            useMarkdown: useMarkdown
        )
        
        return result.firstCapitalized + "."
    }
    
    /**
     Generate an array of sentences.
     - parameter nbSentences: The number of sentences to generate.
     
     - returns: Returns an array of random sentences.
     */
    public class func sentences(nbSentences: Int = 3) -> [String] {
        return (0..<nbSentences).map { _ in sentence() }
    }
    
    /**
     Generate a paragraph with `nbSentences` random sentences.
     - parameter nbSentences: The number of sentences the paragraph should
     contain.
     - parameter variable:    If `true`, the number of sentences will vary
     between +/- 40% of `nbSentences`.
     - returns: Returns a paragraph with `nbSentences` random sentences.
     */
    public class func paragraph(nbSentences: Int = 3, variable: Bool = true) -> String {
        if nbSentences <= 0 {
            return ""
        }
        
        return sentences(nbSentences: variable ? nbSentences.randomize(variation: 40) : nbSentences).joined(separator: " ")
    }
    
    /**
     Generate an array of random paragraphs.
     - parameter nbParagraphs: The number of paragraphs to generate.
     - returns: Returns an array of `nbParagraphs` paragraphs.
     */
    public class func paragraphs(nbParagraphs: Int = 3) -> [String] {
        return (0..<nbParagraphs).map { _ in paragraph() }
    }
    
    /**
     Generate a string of random paragraphs.
     - parameter nbParagraphs: The number of paragraphs to generate.
     - returns: Returns a string of random paragraphs.
     */
    public class func paragraphs(nbParagraphs: Int = 3) -> String {
        return paragraphs(nbParagraphs: nbParagraphs).joined(separator: "\n\n")
    }
    
    /**
     Generate a string of at most `maxNbChars` characters.
     - parameter maxNbChars: The maximum number of characters the string
     should contain.
     - returns: Returns a string of at most `maxNbChars` characters.
     */
    public class func text(maxNbChars: Int = 200) -> String {
        var result: [String] = []
        
        if maxNbChars < 5 {
            return ""
        } else if maxNbChars < 25 {
            while result.count == 0 {
                var size = 0
                
                while size < maxNbChars {
                    let w = (size != 0 ? " " : "") + word()
                    result.append(w)
                    size += w.count
                }
                
                _ = result.popLast()
            }
        } else if maxNbChars < 100 {
            while result.count == 0 {
                var size = 0
                
                while size < maxNbChars {
                    let s = (size != 0 ? " " : "") + sentence()
                    result.append(s)
                    size += s.count
                }
                
                _ = result.popLast()
            }
        } else {
            while result.count == 0 {
                var size = 0
                
                while size < maxNbChars {
                    let p = (size != 0 ? "\n" : "") + paragraph()
                    result.append(p)
                    size += p.count
                }
                
                _ = result.popLast()
            }
        }
        
        return result.joined(separator: "")
    }
}

extension String {
    var firstCapitalized: String {
        var string = self
        string.replaceSubrange(string.startIndex...string.startIndex, with: String(string[string.startIndex]).capitalized)
        return string
    }
}

public extension Array {
    /**
     Shuffle the array in-place using the Fisher-Yates algorithm.
     */
    mutating func shuffle() {
        if count == 0 {
            return
        }

        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            if j != i {
                self.swapAt(i, j)
            }
        }
    }
    
    /**
     Return a shuffled version of the array using the Fisher-Yates
     algorithm.
     
     - returns: Returns a shuffled version of the array.
     */
    func shuffled() -> [Element] {
        var list = self
        list.shuffle()
        
        return list
    }
    
    /**
     Return a random element from the array.
     - returns: Returns a random element from the array or `nil` if the
     array is empty.
     */
    func random() -> Element? {
        return (count > 0) ? self.shuffled()[0] : nil
    }
    
    /**
     Return a random subset of `cnt` elements from the array.
     - returns: Returns a random subset of `cnt` elements from the array.
     */
    func random(_ count: Int = 1) -> [Element] {
        let result = shuffled()
        
        return (count > result.count) ? result : Array(result[0..<count])
    }
}

extension Int {
    /**
     Return a random number between `min` and `max`.
     - note: The maximum value cannot be more than `UInt32.max - 1`
     
     - parameter min: The minimum value of the random value (defaults to `0`).
     - parameter max: The maximum value of the random value (defaults to `UInt32.max - 1`)
     
     - returns: Returns a random value between `min` and `max`.
     */
    public static func random(min: Int = 0, max: Int = Int.max) -> Int {
        precondition(min <= max, "attempt to call random() with min > max")
        
        let diff   = UInt(bitPattern: max &- min)
        let result = UInt.random(min: 0, max: diff)
        
        return min + Int(bitPattern: result)
    }
    
    public func randomize(variation: Int) -> Int {
        let multiplier = Double(Int.random(min: 100 - variation, max: 100 + variation)) / 100
        let randomized = Double(self) * multiplier
        
        return Int(randomized) + 1
    }
}

private extension UInt {
    static func random(min: UInt, max: UInt) -> UInt {
        precondition(min <= max, "attempt to call random() with min > max")
        
        if min == UInt.min && max == UInt.max {
            var result: UInt = 0
            arc4random_buf(&result, MemoryLayout.size(ofValue: result))
            
            return result
        } else {
            let range         = max - min + 1
            let limit         = UInt.max - UInt.max % range
            var result: UInt = 0
            
            repeat {
                arc4random_buf(&result, MemoryLayout.size(ofValue: result))
            } while result >= limit
            
            result = result % range
            
            return min + result
        }
    }
}
