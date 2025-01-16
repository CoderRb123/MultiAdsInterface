//
//  ApiService.swift
//  CommonInterface_ios
//
//  Created by Khusnud Zehra on 15/01/25.
//

import Foundation
import SwiftyJSON

public class ApiService {
     func registerDevice(body: [String: String]) {
        guard let url = URL(string: device_register_url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        print(error)
                    }
                    return
                }
                DispatchQueue.main.async {
                    if(data != nil){
                        let json = try? JSON(data: data!)
                        print(json ?? "Default")
                    }else{
                        print("Multi Ads Response is nil")
                    }
                }
            }.resume()
        } catch {
            DispatchQueue.main.async {
                print(error)
            }
        }
    }
}
