//
//  Copyright © 2018 Dyson
//

import RxCocoa
import RxSwift

extension ObservableType {
    func mapDistinct<R: Equatable>(_ transform: @escaping (E) throws -> R) -> Observable<R> {
        return self.map(transform).distinctUntilChanged()
    }
}

final class BravoViewModel: ViewModel {
    
    enum State {
        case initial
        case loading
        case success
        case failure
    }
    
    struct Strings {
        struct Success {
            static let title = "Data Collected"
            static let body = "The weather data has been successfuly collected"
            static let image = "Success"
        }
        struct Failure {
            static let title = "Unable To Collect Data"
            static let body = "The weather data could not be collected"
            static let image = "Error"
        }
    }
    
    let titleText: Driver<String>
    let bodyText: Driver<String>
    let buttonEnabled: Driver<Bool>
    let progressAnimating: Driver<Bool>
    let iconImage: Driver<String?>
    
    private let dataFetcher: DataFetcher
    private let dataStore: PayloadStore

    private let stateRelay: BehaviorRelay<State>

    init(dataFetcher: DataFetcher, dataStore: PayloadStore) {
        self.dataFetcher = dataFetcher
        self.dataStore = dataStore
        
        stateRelay = BehaviorRelay(value: .initial)
        titleText = stateRelay
            .mapDistinct {
                switch $0 {
                case .failure:
                    return Strings.Failure.title
                case .success:
                    return Strings.Success.title
                default:
                    return ""
                }
            }
            .asDriver(onErrorJustReturn: "Error")
        bodyText = stateRelay
            .mapDistinct {
                switch $0 {
                case .failure:
                    return Strings.Failure.body
                case .success:
                    return Strings.Success.body
                default:
                    return ""
                }
            }
            .asDriver(onErrorJustReturn: "Error")
        
        buttonEnabled = stateRelay
            .mapDistinct { $0 == .success }
            .asDriver(onErrorJustReturn: false)

        progressAnimating = stateRelay
            .mapDistinct { $0 == .loading }
            .asDriver(onErrorJustReturn: false)

        iconImage = stateRelay
            .mapDistinct { $0 == .success ? Strings.Success.image : Strings.Failure.image }
            .asDriver(onErrorJustReturn: nil)
    }
    
    func viewDidLoad() {
        stateRelay.accept(.loading)
        dataFetcher.fetch() { [dataStore, stateRelay] result in
            
            do {
                switch result {
                case .success(let data):
                    
                    let model = try JSONDecoder().decode(WeatherPayload.self, from: data)
                    dataStore.payload = model
                    stateRelay.accept(.success)
                    print(model)
                case .failure(let error):
                    throw error
                }
            } catch {
                print(error.localizedDescription)
                stateRelay.accept(.failure)
            }
        }
    }
    
    func nextButtonPressed() {
        completionHandler()
    }
}
