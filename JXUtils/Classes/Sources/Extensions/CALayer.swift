//
//  CALayer.swift
//  CupertinoStandards
//
//  Created by Jorge Luis on 17/08/18.
//

import UIKit

public enum RectCardinalPoint {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    case left
    case right
    case bottom
    case top
    case center
    case custom(x:CGFloat,y:CGFloat)
    
    public var position: CGPoint {
        switch self {
        case .topLeft: return CGPoint.init(x: 0, y: 0)
        case .topRight: return CGPoint.init(x: 1, y: 0)
        case .bottomLeft: return CGPoint.init(x: 0, y: 1)
        case .bottomRight: return CGPoint.init(x: 1, y: 1)
        case .left: return CGPoint.init(x: 0, y: 0.5)
        case .right: return CGPoint.init(x: 1, y: 0.5)
        case .bottom: return CGPoint.init(x: 0.5, y: 1)
        case .top: return CGPoint.init(x: 0.5, y: 0)
        case .center: return CGPoint.init(x: 0.5, y: 0.5)
        case .custom(let x, let y): return CGPoint.init(x: x, y: y)
        }
    }
}

public enum RectFillDistribution {
    case equally
    case fibonacci
    case custom(locations:[CGFloat])
    
    public func locations(distributingTo elements: Int) -> [NSNumber]? {
        switch self {
        case .equally: return nil
        case .custom(let locations): return locations.map({NSNumber.init(value: Double($0))})
        case .fibonacci:
            let fibonnaccis = Array(CSMathUtils.fibonacci(n: elements).dropFirst()).reversed()
            let total = fibonnaccis.reduce(0, +)
            let distributions = fibonnaccis.map({Double($0) / Double(total)})
            var locationDelimiter: Double = 0
            let locations: [NSNumber] = distributions.map({ distribution in
                locationDelimiter += distribution;
                return NSNumber.init(value: locationDelimiter)
            })
            return locations
        }
    }
}

extension CALayer {
    @discardableResult
    public func insertGradient(from start: RectCardinalPoint = .top, to end: RectCardinalPoint = .bottom,
                        with colors: [UIColor], distribution: RectFillDistribution = .equally, at layerPosition: UInt32 = 0) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.startPoint = start.position
        gradient.endPoint = end.position
        gradient.colors = colors.map({$0.cgColor})
        if let locations = distribution.locations(distributingTo: colors.count) {
            gradient.locations = locations
        }
        gradient.frame = self.bounds
        self.insertSublayer(gradient, at: layerPosition)
        return gradient
    }
}
