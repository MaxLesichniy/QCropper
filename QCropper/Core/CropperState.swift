//
//  CropperState.swift
//
//  Created by Chen Qizhi on 2019/10/15.
//

import UIKit

/// To restore cropper state
public struct CropperState: Codable, Equatable {
    public var viewFrame: CGRect
    public var angle: CGFloat
    public var rotationAngle: CGFloat
    public var straightenAngle: CGFloat
    public var flipAngle: CGFloat
    public var imageOrientationRawValue: Int
    public var scrollViewTransform: CGAffineTransform
    public var scrollViewCenter: CGPoint
    public var scrollViewBounds: CGRect
    public var scrollViewContentOffset: CGPoint
    public var scrollViewMinimumZoomScale: CGFloat
    public var scrollViewMaximumZoomScale: CGFloat
    public var scrollViewZoomScale: CGFloat
    public var cropBoxFrame: CGRect
    public var aspectRatioLocked: Bool
    public var aspectRatio: AspectRatio
    public var aspectRatioValue: CGFloat
    public var photoTranslation: CGPoint
    public var imageViewTransform: CGAffineTransform
    public var imageViewBoundsSize: CGSize
}
