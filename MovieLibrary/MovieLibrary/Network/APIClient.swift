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
    
    func fetchMoviesList(_ listUrl:String , _ completionHandler: @escaping(_ data:Movies?,  _ error:Error?) -> Void) ->Void{
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
    
    func getImage(url:URL,_ completionHandler: @escaping(_ data:Data?) -> Void) ->Void{
        self.requestApi(url: url) { (data, response, error) in
            if let data = data{
                completionHandler(data)
            }
            completionHandler(nil)
        }
    }
}
