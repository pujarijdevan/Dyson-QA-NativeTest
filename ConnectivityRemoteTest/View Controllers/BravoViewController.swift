//
//  Copyright © 2018 Dyson
//

import UIKit

import RxCocoa
import RxSwift

final class BravoViewController: UIViewController {

    var viewModel: BravoViewModel?
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var buttonContainer: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem?.title = ""
        navigationController?.interactivePopGestureRecognizer?.delegate = self

        viewModel?.titleText
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel?.bodyText
            .drive(bodyLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel?.buttonEnabled
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        viewModel?.buttonEnabled
            .map { !$0 }
            .drive(buttonContainer.rx.isHidden)
            .disposed(by: disposeBag)
        viewModel?.iconImage
            .map { (name: String?) -> UIImage? in
                guard let imageName = name else {
                    return nil
                }
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

        nextButton.rx.tap
            .subscribe(onNext: { [viewModel] in
                viewModel?.nextButtonPressed()
            })
            .disposed(by: disposeBag)

        viewModel?.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationItem.setHidesBackButton(false, animated: true)
        super.viewDidDisappear(animated)
    }
}

extension BravoViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
