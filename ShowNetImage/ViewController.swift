//
//  ViewController.swift
//  ShowNetImage
//
//  Created by Roma on 27.02.22.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        activityIndicator.hidesWhenStopped = true
    }

    private let imageUrls = ["https://www.nasa.gov/sites/default/files/thumbnails/image/hubble_arp298_potw2208a.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/pia23689.jpeg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/28x6_x-59_rdg-6753_average_cleaned_red_blue_black.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/imagesvenus20191211venus20191211-16.jpeg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/28x6_x-59_rdg-6753_average_cleaned_red_blue_black11111.jpg",
    ]

    let errorImage = UIImage(named: "errorImage")

    var timer: Timer?
    var counter = 0

    private func fetchImage() {

        for image in imageUrls {

            guard let url = URL(string: image) else { return }

            let session = URLSession.shared

            activityIndicator.startAnimating()

            let task = session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {

                    self.activityIndicator.stopAnimating()

                    if let error = error, let image = self.errorImage {
                        self.imageView.image = image
                        print(error.localizedDescription)
                        return
                    }
                    if let response = response {
                        print(response)
                    }
                    print("\n", data ?? "", "\n")
                    if let data = data, let image = UIImage(data: data) {
                        self.timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { (timer) in
                            self.imageView.image = image
                        })

                    } else {
                        
                    }
                }
            }
            task.resume()

        }
    }
}

