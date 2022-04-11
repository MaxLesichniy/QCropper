//
//  AspectRatio.swift
//
//  Created by Chen Qizhi on 2019/10/16.
//

import Foundation

public enum AspectRatioOrientation: Hashable {
    case any
    case vertical
    case horizontal
    
    public var rotated: AspectRatioOrientation {
        switch self {
        case .vertical:
            return .horizontal
        case .horizontal:
            return .vertical
        default:
            return self
        }
    }
}

public enum AspectRatio: Hashable {
    case original
    case freeForm
    case square
    case ratio(width: Int, height: Int)

    public var rotated: AspectRatio {
        switch self {
        case let .ratio(width, height):
            return .ratio(width: height, height: width)
        default:
            return self
        }
    }

    public var orientation: AspectRatioOrientation {
        switch self {
        case let .ratio(width, height) where width > height:
            return .horizontal
        case let .ratio(width, height) where width < height:
            return .vertical
        default:
            return .any
        }
    }
    
    public func withOrientation(_ orientation: AspectRatioOrientation) -> AspectRatio {
        if orientation != self.orientation {
            return rotated
        } else {
            return self
        }
    }
    
    var description: String {
        switch self {
        case .original:
            return "ORIGINAL"
        case .freeForm:
            return "FREEFORM"
        case .square:
            return "SQUARE"
        case let .ratio(width, height):
            return "\(width):\(height)"
        }
    }
}

// MARK: Codable

extension AspectRatio: Codable {
    enum CodingKeys: String, CodingKey {
        case description
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let desc = try container.decodeIfPresent(String.self, forKey: .description) else {
            self = .freeForm
            return
        }
        switch desc {
        case "ORIGINAL":
            self = .original
        case "FREEFORM":
            self = .freeForm
        case "SQUARE":
            self = .square
        default:
            let numberStrings = desc.split(separator: ":")
            if numberStrings.count == 2,
                let width = Int(numberStrings[0]),
                let height = Int(numberStrings[1]) {
                self = .ratio(width: width, height: height)
            } else {
                self = .freeForm
            }
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(description, forKey: .description)
    }
}

extension AspectRatio: Equatable {
    public static func == (lhs: AspectRatio, rhs: AspectRatio) -> Bool {
        switch (lhs, rhs) {
        case (let .ratio(lhsWidth, lhsHeight), let .ratio(rhsWidth, rhsHeight)):
            return lhsWidth == rhsWidth && lhsHeight == rhsHeight
        case (.original, .original),
             (.freeForm, .freeForm),
             (.square, .square):
            return true
        default:
            return false
        }
    }
}
