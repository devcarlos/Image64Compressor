# Image64Compressor
> Image64Compressor - Image Assets (PDF, PNG, JPEG ) String Base 64 Encode Compressor

[![Swift 5.0](https://img.shields.io/badge/swift-5.0-red.svg?style=flat)](https://developer.apple.com/swift)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/Image64Compressor.svg?style=flat-square)](http://makeapullrequest.com)

Image64Compressor - Image Assets (PDF, PNG, JPEG ) String Base 64 Encode Compressor

## Features

- [x] Image64Compressor

## Requirements

- iOS 11+
- Xcode 11
- Swift 5.0

## Usage

#### Console

1. Move the Assets (Assets.xcassets) directory you want to compress to your desktop or a working filepath:

```ruby
mv Assets.xcassets /Users/user/Desktop/Assets
```

2. Setup the `Image64Compressor` Xcode project arguments to your command-line tool:

- Click on the Scheme named Image64Compressor in the Toolbar:

- Select Edit Scheme from the menu that appears

- Ensure Run is selected in the left pane, click the Arguments tab, then click the + sign under Arguments Passed On Launch. Add your working filepath (like /Users/user/Desktop/Assets) as argument and click Close.

3. Execute the `Image64Compressor` Xcode project and wait for the process to finish and create your template files.

4. In case of error check the filepath setup is set correctly

5. After compression success move the `Asset.swift` and `Items.swift` generated files to the example Xcode project and test the Image Base 64 Assets, following the "example" asset.

## Contribute

We would love you for the contribution to **Image64Compressor**, check the ``LICENSE`` file for more info.

## Authors

* Manuel Alejandro Perez Rosabal (Clark Kent) (marosabal@icloud.com)
* Carlos Alcala aka Charles Xavier (Profesori) (carlos.alcala@me.com)

## License

Image64Compressor is distributed under the MIT license. See ``LICENSE`` for more information.
