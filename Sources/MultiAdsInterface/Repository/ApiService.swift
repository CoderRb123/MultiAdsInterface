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

            URLSession.shared.dataTask(with: request) { _, response, error in
                if let error = error {
                    DispatchQueue.main.async {}
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                    DispatchQueue.main.async {
                    }
                    return
                }
                DispatchQueue.main.async {}
            }.resume()
        } catch {
            DispatchQueue.main.async {}
        }
    }
}
