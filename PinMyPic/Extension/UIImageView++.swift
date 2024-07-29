//
//  UIImageView++.swift
//  PinMyPic
//
//  Created by 하연주 on 7/25/24.
//

import UIKit

extension UIImageView {
    func configureDefaultImageView() {
        self.backgroundColor = Assets.Colors.gray2
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
    }
    
    func loadImage(urlString : String, filename : String? = nil) {
        
        if #available(iOS 16.0, *) {
            if let filename, let image = ImageSavingManager.loadImageFromDocument(filename: filename)  {
                //파일매니저에 저장된 이미지가 있으면
                self.image = image
                return
            }
        }
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self, let data, let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {[weak self] in
                guard let self else{return}
                
                self.image = image
            }
        }
        task.resume()
    }
    
}
