//
//  Copyright © 2018 Dyson
//

import UIKit
import RxSwift
import RxCocoa

class AlphaViewController: UIViewController {
    
    var viewModel: AlphaViewModel!

    private let disposeBag = DisposeBag()
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var buttonContainer: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem?.title = ""
        
        viewModel?.titleText
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel?.bodyText
            .drive(bodyLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel?.buttonAlpha
            .drive(nextButton.titleLabel!.rx.alpha)
            .disposed(by: disposeBag)
        viewModel?.buttonAlpha
            .drive(buttonContainer.rx.alpha)
            .disposed(by: disposeBag)
        viewModel?.iconImage
            .map { (imageName: String) -> UIImage? in
                return UIImage(named: imageName)
            }
            .drive(iconImageView.rx.image)
            .disposed(by: disposeBag)
        viewModel?.progressAnimating
            .drive(spinner.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel?.progressAnimating
            .drive(iconImageView.rx.isHidden)
            .disposed(by: disposeBag)

        nextButton.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.viewModel.nextButtonPressed()
        }).disposed(by: disposeBag)
    }
}
