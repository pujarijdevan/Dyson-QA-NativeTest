//
//  Copyright © 2018 Dyson
//

import UIKit
import RxSwift
import RxCocoa

class CharlieViewController: UIViewController {
    @IBOutlet private weak var weatherIcon: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var nextButton: UIButton!

    var viewModel: CharlieViewModel?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.weatherText
            .drive(descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel?.temperatureText
            .drive(temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel?.buttonEnabled
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        viewModel?.iconImage
            .map { (name: String?) -> UIImage? in
                guard let imageName = name else {
                    return nil
                }
                return UIImage(named: imageName)
            }
            .drive(weatherIcon.rx.image)
            .disposed(by: disposeBag)

        nextButton.rx.tap
            .subscribe(onNext: { [viewModel] in
                viewModel?.nextButtonPressed()
            })
            .disposed(by: disposeBag)
    }
}
