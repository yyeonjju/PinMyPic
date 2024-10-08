//
//  APIFetcher.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import Foundation
import Alamofire


protocol APIFetchable {
    func getSearchPhoto(keyword : String, page: Int, sortOrder : SortOrder, handler: @escaping (Result<SearchPhoto, RequestError>) -> Void)
    func getTopicPhotos(topicSlug : String, handler: @escaping (Result<[PhotoResult], RequestError>) -> Void)
    func getPhotoStatistic(imageId : String, handler: @escaping (Result<PhotoStatistic, RequestError>) -> Void)
}


class APIFetcher {
    static let shared = APIFetcher()
    private init(){}
    
    private func fetch<T : Decodable>(
        model : T.Type,
        requestType : RequestType,
        completionHandler : @escaping (Result<T, RequestError>) -> Void
    ) {
        ///URLComponents
        guard var component = URLComponents(string: requestType.endpoint) else {return }
        let queryItemArray = requestType.parameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        component.queryItems = queryItemArray
        
        ///URLRequest
        guard let url = component.url else {return  completionHandler(.failure(.url))}
        let request = try? URLRequest(url: url, method: requestType.method, headers: requestType.headers)

        guard let request else {return  completionHandler( .failure(.urlRequestError)) }
        
        
        
        ///dataTask
        URLSession.shared.dataTask(with: request) {data, response, error in
            
            DispatchQueue.main.async {
                
                guard error == nil else {
                    completionHandler(.failure(.failedRequest))
                    return
                }
                
                guard let data else {
                    completionHandler(.failure(.noData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(.failure(.invalidResponse))
                    return
                }
                
                guard response.statusCode == 200 else {
                    var errorMessage: String?
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: [String]] {
                        errorMessage = json["errors"]?.first
                    }
                    completionHandler(.failure(.failResponse(code: response.statusCode, message: errorMessage ?? "-")))

                    return
                }
                
                
                
                do {
                    let result = try JSONDecoder().decode(model.self, from: data)

                    completionHandler(.success(result))
                }catch {
                    completionHandler(.failure(.invalidData))
                }
            }

        }
        .resume()
    }
    
    
}

extension APIFetcher : APIFetchable {
    func getSearchPhoto(keyword : String, page: Int, sortOrder : SortOrder, handler: @escaping (Result<SearchPhoto, RequestError>) -> Void) {
        let requestType = RequestType.searchPhoto(query: keyword, page : page, sortOrder : sortOrder)
        
        fetch(model : SearchPhoto.self, requestType : requestType){ result in
            handler(result)
        }
    }
    
    func getTopicPhotos(topicSlug : String, handler: @escaping (Result<[PhotoResult], RequestError>) -> Void) {
        let requestType = RequestType.topicPhotos(topicSlug: topicSlug)
        
        fetch(model : [PhotoResult].self, requestType : requestType){ result in
            handler(result)
        }
    }
    
    func getPhotoStatistic(imageId : String, handler: @escaping (Result<PhotoStatistic, RequestError>) -> Void) {
        let requestType = RequestType.photoStatistic(imageId: imageId)
        
        fetch(model : PhotoStatistic.self, requestType : requestType){ result in
            handler(result)
        }
    }
}

