//
//  MoviePosterViewController.swift
//  boxoffice_boostcamp_3_ios
//
//  Created by Seonghun Kim on 08/12/2018.
//  Copyright © 2018 Seonghun Kim. All rights reserved.
//

import UIKit

class MoviePosterViewController: UIViewController {
    // MARK:- Properties
    @IBOutlet weak var moviePosterImageView: UIImageView!
    var posterImage: UIImage?
    
    // MARK:- Initialize
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = posterImage else {
            dismiss(animated: true, completion: { print("Fail to Display Poster Image") }) 
            return
        }

        moviePosterImageView.image = image
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(touchUpPosterImageView(_:)))
        moviePosterImageView.addGestureRecognizer(tapGesture)
    }
    
    // MARK:- Touch Up Poster Image
    @objc private func touchUpPosterImageView(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
