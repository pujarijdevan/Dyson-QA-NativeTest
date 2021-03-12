//
//  Copyright © Dyson 2019
//

import Alamofire

enum FetchStatus {
    case success(data: Data)
    case failure(error: Error)
}

/// Provides an arbitrary chunk of data when requested.
protocol DataFetcher {
    /// Provides an arbitrary chunk of `Data` as a next event and then completes.
    func fetch(completion: @escaping (FetchStatus) -> Void)
}

class HttpDataFetcher: DataFetcher {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func fetch(completion: @escaping (FetchStatus) -> Void) {
        Alamofire.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data: data))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
}
