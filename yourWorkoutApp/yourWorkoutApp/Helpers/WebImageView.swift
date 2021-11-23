//
//  WebImageView.swift
//  ElonDream
//
//  Created by Вякулин Сергей on 13.09.2021.
//

import UIKit

class WebImageView: UIImageView {
    
    private var currentUrlString: String?
    
    //функция для обновления элемента изображения
    func set(imgeURL: String?) {
        currentUrlString = imgeURL
        guard let imgeURL = imgeURL, let url = URL(string: imgeURL) else {
            self.image = nil
            return}
        
        //проверяем, есть ли изображение в кэше и если есть сразу присваиваем
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            return
        }
        
        //работаем с ссылкой на изображение и получением изображения
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    //проверяем и получаем изображение из кэша
    private func handleLoadedImage(data: Data, response: URLResponse){
        guard let responseURL = response.url else { return }
        let chachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(chachedResponse, for: URLRequest(url: responseURL))
        guard responseURL.lastPathComponent == URL(string: currentUrlString ?? "")?.lastPathComponent else {return}
        self.image = UIImage(data: data)
    }
}


