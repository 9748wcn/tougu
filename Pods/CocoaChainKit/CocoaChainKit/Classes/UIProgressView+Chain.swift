//
//  UIProgressView+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/9.
//

public extension Chain where Base: UIProgressView {
    
    @discardableResult
    func progress(_ progress: Float) -> Chain {
        base.progress = progress
        return self
    }
    
    @discardableResult
    func progressViewStyle(_ progressViewStyle: ProgressViewStyle) -> Chain {
        base.progressViewStyle = progressViewStyle
        return self
    }
    
    @discardableResult
    func progressTintColor(_ progressTintColor: UIColor?) -> Chain {
        base.progressTintColor = progressTintColor
        return self
    }
    
    @discardableResult
    func trackTintColor(_ trackTintColor: UIColor?) -> Chain {
        base.trackTintColor = trackTintColor
        return self
    }
    
    @discardableResult
    func progressImage(_ progressImage: UIImage?) -> Chain {
        base.progressImage = progressImage
        return self
    }
    
    @discardableResult
    func trackImage(_ trackImage: UIImage?) -> Chain {
        base.trackImage = trackImage
        return self
    }
}
