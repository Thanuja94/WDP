//
//  LoadingView.swift
//  WDP
//
//  Created by Thathsara Senarathne on 2021-05-09.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    private var size:CGSize
    private var centerView:CGPoint{
        let point  = CGPoint(x: (self.bounds.size.width / 2) - (size.width / 2), y: (self.bounds.size.height / 2)-(size.height / 2))
        return point
    }
    
    fileprivate lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView.init(style: .medium)
        ai.color = .white
        ai.frame = CGRect(origin: self.centerView, size: self.size)
        ai.hidesWhenStopped = true
        ai.contentMode = .scaleAspectFit
        return ai
    }()
    
    fileprivate lazy var background:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.frame = self.bounds
        return view
    }()
    
    fileprivate var hasSuperView:Bool{
        guard self.superview == nil else{return true}
        return false
    }
    
    init(frame:CGRect,animationSize size:CGSize = CGSize(width: 32, height: 32)) {
        self.size = size
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




//MARK:- LOADING ANIMATION VIEW FUNCTIONNING HAPPENING HERE...
extension LoadingView {
    
    //MARK:- START LOADING WITH BLACK BACKGROUND
    func start(in target:UIView?,withBackground isBackgroundShow:Bool = false){
        guard hasSuperView else{addView(target, isBackgroundShow);return}
        activityIndicator.startAnimating()
        guard isBackgroundShow else{return}
        target?.insertSubview(background, belowSubview: activityIndicator)
    }
    
    private func addView(_ target:UIView?,_ isWithBackground:Bool){
        target?.addSubview(self)
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        guard isWithBackground else{return}
        self.insertSubview(background, belowSubview: activityIndicator)
    }

    
    //MARK:- STOP LOADING AND REMOVE FROM VIEW..
    func stop(){
        guard hasSuperView else{return}
        activityIndicator.stopAnimating()
        self.removeFromSuperview()
    }
    
    //MARK:- PAUSE THE IF IT PLAYING
    func pause(){
        guard activityIndicator.isAnimating else{return}
        activityIndicator.stopAnimating()
    }
    
    //MARK:- CHECK IF LOADING ANIMATION VIEW IS SUBVIEW CURRENT STATE..
    var isAnimating:Bool{
        return hasSuperView
    }
}
