import UIKit

enum LCDBorderStyle {
    case none
    case single
    case raised
    case lowered
}

enum LCDDotMatrixStyle {
    case matrix5x7
    case matrix5x8
}

typealias Font = [Character: [String]]

let matrix5x7Font: Font = [
    "\u{00020}": ["00000", "00000", "00000", "00000", "00000", "00000", "00000"],
    "!": ["00100", "00100", "00100", "00100", "00100", "00000", "00100"],
    "\"": ["01010", "01010", "01010", "00000", "00000", "00000", "00000"],
    "#": ["01010", "01010", "11111", "01010", "11111", "01010", "01010"],
    "$": ["00100", "01111", "10100", "01110", "00101", "11110", "00100"],
    "%": ["11000", "11001", "00010", "00100", "01000", "10011", "00011"],
    "&": ["01100", "10010", "10100", "01000", "10101", "10010", "01101"],
    "'": ["01100", "00100", "01000", "00000", "00000", "00000", "00000"],
    "(": ["00010", "00100", "01000", "01000", "01000", "00100", "00010"],
    ")": ["01000", "00100", "00010", "00010", "00010", "00100", "01000"],
    "*": ["00000", "00100", "10101", "01110", "10101", "00100", "00000"],
    "+": ["00000", "00100", "00100", "11111", "00100", "00100", "00000"],
    ",": ["00000", "00000", "00000", "00000", "01100", "00100", "01000"],
    "-": ["00000", "00000", "00000", "11111", "00000", "00000", "00000"],
    ".": ["00000", "00000", "00000", "00000", "00000", "01100", "01100"],
    "/": ["00000", "00001", "00010", "00100", "01000", "10000", "00000"],
    "0": ["01110", "10001", "10011", "10101", "11001", "10001", "01110"],
    "1": ["00100", "01100", "00100", "00100", "00100", "00100", "01110"],
    "2": ["01110", "10001", "00001", "00010", "00100", "01000", "11111"],
    "3": ["11111", "00010", "00100", "00010", "00001", "10001", "01110"],
    "4": ["00010", "00110", "01010", "10010", "11111", "00010", "00010"],
    "5": ["11111", "10000", "11110", "00001", "00001", "10001", "01110"],
    "6": ["00110", "01000", "10000", "11110", "10001", "10001", "01110"],
    "7": ["11111", "00001", "00010", "00100", "01000", "01000", "01000"],
    "8": ["01110", "10001", "10001", "01110", "10001", "10001", "01110"],
    "9": ["01110", "10001", "10001", "01111", "00001", "00010", "01100"],
    ":": ["00000", "01100", "01100", "00000", "01100", "01100", "00000"],
    ";": ["00000", "01100", "01100", "00000", "01100", "00100", "01000"],
    "<": ["00010", "00100", "01000", "10000", "01000", "00100", "00010"],
    "=": ["00000", "00000", "11111", "00000", "11111", "00000", "00000"],
    ">": ["01000", "00100", "00010", "00001", "00010", "00100", "01000"],
    "?": ["01110", "10001", "00001", "00010", "00100", "00000", "00100"],
    "@": ["01110", "10001", "00001", "01101", "10101", "10101", "01110"],
    "A": ["01110", "10001", "10001", "10001", "11111", "10001", "10001"],
    "B": ["11110", "10001", "10001", "11110", "10001", "10001", "11110"],
    "C": ["01110", "10001", "10000", "10000", "10000", "10001", "01110"],
    "D": ["11100", "10010", "10001", "10001", "10001", "10010", "11100"],
    "E": ["11111", "10000", "10000", "11110", "10000", "10000", "11111"],
    "F": ["11111", "10000", "10000", "11110", "10000", "10000", "10000"],
    "G": ["01110", "10001", "10000", "10111", "10001", "10001", "01111"],
    "H": ["10001", "10001", "10001", "11111", "10001", "10001", "10001"],
    "I": ["01110", "00100", "00100", "00100", "00100", "00100", "01110"],
    "J": ["00111", "00010", "00010", "00010", "00010", "10010", "01100"],
    "K": ["10001", "10010", "10100", "11000", "10100", "10010", "10001"],
    "L": ["10000", "10000", "10000", "10000", "10000", "10000", "11111"],
    "M": ["10001", "11011", "10101", "10101", "10001", "10001", "10001"],
    "N": ["10001", "10001", "11001", "10101", "10011", "10001", "10001"],
    "O": ["01110", "10001", "10001", "10001", "10001", "10001", "01110"],
    "P": ["11110", "10001", "10001", "11110", "10000", "10000", "10000"],
    "Q": ["01110", "10001", "10001", "10001", "10101", "10010", "01101"],
    "R": ["11110", "10001", "10001", "11110", "10100", "10010", "10001"],
    "S": ["01111", "10000", "10000", "01110", "00001", "00001", "11110"],
    "T": ["11111", "00100", "00100", "00100", "00100", "00100", "00100"],
    "U": ["10001", "10001", "10001", "10001", "10001", "10001", "01110"],
    "V": ["10001", "10001", "10001", "10001", "10001", "01010", "00100"],
    "W": ["10001", "10001", "10001", "10101", "10101", "10101", "01010"],
    "X": ["10001", "10001", "01010", "00100", "01010", "10001", "10001"],
    "Y": ["10001", "10001", "10001", "01010", "00100", "00100", "00100"],
    "Z": ["11111", "00001", "00010", "00100", "01000", "10000", "11111"],
    "[": ["01110", "01000", "01000", "01000", "01000", "01000", "01110"],
    "\\": ["00000", "10000", "01000", "00100", "00010", "00001", "00000"],
    "]": ["01110", "00010", "00010", "00010", "00010", "00010", "01110"],
    "^": ["00100", "01010", "10001", "00000", "00000", "00000", "00000"],
    "_": ["00000", "00000", "00000", "00000", "00000", "00000", "11111"],
    "`": ["01000", "00100", "00010", "00000", "00000", "00000", "00000"],
    "a": ["00000", "00000", "01110", "00001", "01111", "10001", "01111"],
    "b": ["10000", "10000", "10110", "11001", "10001", "10001", "11110"],
    "c": ["00000", "00000", "01110", "10000", "10000", "10001", "01110"],
    "d": ["00001", "00001", "01101", "10011", "10001", "10001", "01111"],
    "e": ["00000", "00000", "01110", "10001", "11111", "10000", "01110"],
    "f": ["00110", "01001", "01000", "11100", "01000", "01000", "01000"],
    "g": ["00000", "01111", "10001", "10001", "01111", "00001", "01110"],
    "h": ["10000", "10000", "10110", "11001", "10001", "10001", "10001"],
    "i": ["00100", "00000", "01100", "00100", "00100", "00100", "01110"],
    "j": ["00010", "00000", "00110", "00010", "00010", "10010", "01100"],
    "k": ["10000", "10000", "10010", "10100", "11000", "10100", "10010"],
    "l": ["01100", "00100", "00100", "00100", "00100", "00100", "01110"],
    "m": ["00000", "00000", "11010", "10101", "10101", "10001", "10001"],
    "n": ["00000", "00000", "10110", "11001", "10001", "10001", "01110"],
    "o": ["00000", "00000", "01110", "10001", "10001", "10001", "01110"],
    "p": ["00000", "00000", "11110", "10001", "11110", "10000", "10000"],
    "q": ["00000", "00000", "01101", "10011", "01111", "00001", "00001"],
    "r": ["00000", "00000", "10110", "11001", "10000", "10000", "10000"],
    "s": ["00000", "00000", "01110", "10000", "01110", "00001", "11110"],
    "t": ["01000", "01000", "11100", "01000", "01000", "01001", "00110"],
    "u": ["00000", "00000", "10001", "10001", "10001", "10011", "01001"],
    "v": ["00000", "00000", "10001", "10001", "10001", "01010", "00100"],
    "w": ["00000", "00000", "10001", "10001", "10101", "10101", "01010"],
    "x": ["00000", "00000", "10001", "01010", "00100", "01010", "10001"],
    "y": ["00000", "00000", "10001", "10001", "01111", "00001", "01110"],
    "z": ["00000", "00000", "11111", "00010", "00100", "01000", "11111"],
    "{": ["00010", "00100", "00100", "01000", "00100", "00100", "00010"],
    "|": ["00100", "00100", "00100", "00100", "00100", "00100", "00100"],
    "}": ["01000", "00100", "00100", "00010", "00100", "00100", "01000"],
    "\u{00B0}": ["01110", "01010", "01110", "00000", "00000", "00000", "00000"]
]


@IBDesignable
public class LCDView: UIView {
    @IBInspectable open var caption: String {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.white
    
    @IBInspectable var dotOnColor: UIColor = UIColor.init(red: 0.0, green: 0.9, blue: 0.0, alpha: 1.0)
    
    @IBInspectable var dotOffColor: UIColor = UIColor.init(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0)
    
    @IBInspectable var dotSpacing: Int {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var dotWidth: Int {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var dotHeight: Int {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var characterSpacing: Int {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var padding: Int {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var font: Font?
    var dotMatrixStyle: LCDDotMatrixStyle?
    var borderStyle: LCDBorderStyle = .none
    var matrixWidth = 5
    var matrixHeight = 7
    
    override init(frame: CGRect) {
        self.dotMatrixStyle = .matrix5x7
        // TODO: Set matrix width and height based on style constant
        
        self.font = matrix5x7Font

        self.caption = ""
        self.dotSpacing = 4
        self.characterSpacing = 8
        self.padding = 4
        self.dotWidth = 4
        self.dotHeight = 4

        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.caption = ""
        self.dotSpacing = 4
        self.characterSpacing = 8
        self.padding = 4
        self.dotWidth = 4
        self.dotHeight = 4

        super.init(coder: aDecoder)
        
        self.dotMatrixStyle = .matrix5x7
        // TODO: Set matrix width and height from style constant
        
        self.font = matrix5x7Font        
    }
    
    public override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        var xpos = CGFloat(self.padding + 5)
        let ypos = CGFloat(1 + self.padding + 5)
        let charWidth = CGFloat(self.matrixWidth * self.dotWidth + ((self.matrixWidth - 1) * self.dotSpacing))
        
        for ch in self.caption {
            drawCharacter(ch, at: CGPoint(x: xpos, y: ypos), in: context)
            xpos = xpos + CGFloat(charWidth) + CGFloat(self.characterSpacing)
        }
    }

    func drawCharacter(_ character: Character, at: CGPoint, in context: CGContext) {
        guard let font = self.font else {
            debugPrint("Font not set")
            return
        }
        
        let charLines = font[character] ?? font["\u{00020}"]
        
        var tx = at.x
        var ty = at.y
        
        for i in 0..<self.matrixHeight {
            let line = charLines![i]
            var dotInfo = [Int]()
            for ch in line {
                if ch == "1" {
                    dotInfo.append(1)
                } else {
                    dotInfo.append(0)
                }
            }

            for j in 0..<self.matrixWidth {
                let charDot = dotInfo[j]
                var color: CGColor?
                if charDot == 1 {
                    color = self.dotOnColor.cgColor
                } else if charDot == 0 {
                    color = self.dotOffColor.cgColor
                } else {
                    color = self.backgroundColor?.cgColor
                }
                context.setFillColor(color!)

                context.move(to: CGPoint(x: tx, y: tx))

                let dotRect = CGRect(x: tx, y: ty, width: CGFloat(self.dotWidth), height: CGFloat(self.dotHeight))
                context.addRect(dotRect)

                context.fillPath()
                
                tx += CGFloat(self.dotWidth + self.dotSpacing)
            }
            
            tx = at.x
            ty += CGFloat(self.dotHeight + self.dotSpacing)
        }
    }
}