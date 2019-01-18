//
//  ImageUtilityProtocol.swift
//  boxoffice_boostcamp_3_ios
//
//  Created by Seonghun Kim on 09/12/2018.
//  Copyright © 2018 Seonghun Kim. All rights reserved.
//

import UIKit
/*
 스위프트 가이드 문서에 보면 프로토콜의 네이밍은 아래와 같은 방식을 추천하고 있습니다.
 
 Protocols that describe what something is should read as nouns (e.g. Collection).
 
 Protocols that describe a capability should be named using the suffixes able, ible, or ing (e.g. Equatable, ProgressReporting). */

// MARK:- Image Assets Name Protocol
protocol Fetchable {
    func selectStarRateImage(index: Int, rate: Double) -> UIImage? //동사형으로 메서드 이름을 바꾸었습니다.
    func fetchThumbImage(url: String, completiopn: @escaping(UIImage?) -> Void)
}

extension Fetchable {
    // MARK:- Return Star Rating Image
    /**
     Return UIImage for Five Start Rating.
    
     This Method return Star Image to Rating Image Array. It works Based Five Star Rating.
     
     - parameters:
        - index: Index to Star Rating Image.
        - rate: Target Rate to Star Rating.
     */
    public func selectStarRateImage(index: Int, rate: Double) -> UIImage? {
        switch true {
        case rate >= (Double(index) * 2.0) + 2.0:
            return UIImage(named: "ic_star_large_full")
        case rate >= (Double(index) * 2.0) + 1.0 && rate < (Double(index) * 2.0) + 2.0:
            return UIImage(named: "ic_star_large_half")
        default:
            return UIImage(named: "ic_star_large")
        }
    }
    
    // MARK:- Fetch Thumb Image From URL
    /**
     Download Thumb Image to url.
     
     This Method download with Asynchronous. After finish download Image, Call completion. If you want to get Image from URL with Asynchronous, Use this Method and Define completion for Bring downloaded Image.
     
     ```
     let url: String = "https://urladdress"
     
     fetchThumbImage(url: url, completion: { (thumbImage: UIImage?) in
        if let image = thumbImage {
            // Success Download Image
        } else {
            // Fail Download Image
        }
     })
     ```
     
     - parameters:
         - url: URL String to Thumb.
         - completiopn: It's going to work after finish download Thumb Image. If fail to download, UIImage is nil.
     */
    public func fetchThumbImage(url: String, completiopn: @escaping(UIImage?) -> Void) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        DispatchQueue.global().async {
            guard let url = URL(string: url), let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                completiopn(nil)
                return
            }
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            completiopn(image)
            
        }
    }
}