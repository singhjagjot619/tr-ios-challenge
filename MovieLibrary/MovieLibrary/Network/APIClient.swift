//
//  APIClient.swift
//  MovieLibrary
//
//  Created by Jagjot Singh on 30/03/21.
//

import Foundation

class APIClient {
    
    let baseUrl = "https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master"
    
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    fileprivate func requestApi(url: URL,
                                _ completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // fetchMoviesList(_ listUrl,  _ completionHandler) API call to get movies list
    func fetchMoviesList(_ listUrl:String , _ completionHandler: @escaping(_ data:Movies?, _ error:Error?) -> Void) ->Void{
        let moviesLisUrl = baseUrl + listUrl
        guard let url = URL(string: moviesLisUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let data = data{
                print(data)
                do {
                    let modeldata:Movies = try JSONDecoder().decode(Movies.self, from: data)
                    print(modeldata)
                    completionHandler(modeldata,err);
                    
                } catch {
                    completionHandler(nil, nil);
                }
            }
            if let res = res{
                print(res)
            }
            if let err = err{
                print(err)
            }
            completionHandler(nil,err);
        }.resume()
    }
    
    // fetchMovieDetails(_ id,  _ completionHandler) API call to get movie details for the given id
    func fetchMovieDetails(_ id:Int,_ completionHandler: @escaping(_ data:MovieDetails?,  _ error:Error?) -> Void) ->Void{
        let detailUrl = baseUrl + "/details/\(id).json"
        guard let url = URL(string: detailUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let data = data{
                do {
                    let modeldata:MovieDetails = try JSONDecoder().decode(MovieDetails.self, from: data)
                    print(modeldata)
                    completionHandler(modeldata,err);
                    
                } catch {
                    completionHandler(nil,nil);
                }
            }
            if let res = res{
                print(res)
            }
            if let err = err{
                print(err)
            }
            completionHandler(nil,err);
        }.resume()
        
    }
    
    // fetchRecommendationsList(_ id,  _ completionHandler) API call to get movie recommendations for the given id
    func fetchRecommendationsList(_ id:Int , _ completionHandler: @escaping(_ data:Movies?,  _ error:Error?) -> Void) ->Void{
        let moviesLisUrl = baseUrl + "/details/recommended/\(id).json"
        guard let url = URL(string: moviesLisUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let data = data{
                print(data)
                do {
                    let modeldata:Movies = try JSONDecoder().decode(Movies.self, from: data)
                    print(modeldata)
                    completionHandler(modeldata,err);
                    
                } catch {
                    completionHandler(nil, nil);
                }
            }
            if let res = res{
                print(res)
            }
            if let err = err{
                print(err)
            }
            completionHandler(nil,err);
        }.resume()
    }
    
    // getImage(_ url,  _ completionHandler) API call to download the image data for the input url
    func getImage(url:URL,_ completionHandler: @escaping(_ data:Data?) -> Void) ->Void{
        if let cachedImage = self.getCacheImage(url.absoluteString){
            completionHandler(cachedImage)
            return
        }
        self.requestApi(url: url) { (data, response, error) in
            if let data = data{
                self.setCacheImage(data, strUrl: url.absoluteString)
                completionHandler(data)
            } else {
                self.setCacheImage(Data(), strUrl: url.absoluteString)
            }
            completionHandler(nil)
        }
    }
    
    // getCacheImage(_ strUrl) Responsible to get the cached image for the urlstring
    func getCacheImage(_ strUrl:String) -> Data?{
        return APIClient.imageCache.object(forKey: strUrl as AnyObject) as? Data
    }
    
    // setCacheImage(_ strUrl) Responsible to cache the image for the input image data
    func setCacheImage(_ data:Data?, strUrl:String){
        APIClient.imageCache.setObject(data as AnyObject, forKey: strUrl as AnyObject)
    }
}
