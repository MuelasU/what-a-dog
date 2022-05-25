//
//  CameraTests.swift
//  what-a-dogTests
//
//  Created by Larissa Gomes de Stefano Escaliante on 24/05/22.
//

import AVFoundation
@testable import what_a_dog
import XCTest

class CameraTest: CaptureDevice {
    var captureAction: ((UIImage) -> Void)!

    func setCaptureAction(_ captureAction: @escaping (UIImage) -> Void) {
        self.captureAction = captureAction
    }

    func getView() -> UIView { return UIView() }

    func setUp() {}

    func takePicture() { captureAction(UIImage()) }
}

class CameraTests: XCTestCase {
    private var viewModel: CameraViewModel!

    override func setUp() {
        super.setUp()
        viewModel = .init()
        let camera = CameraTest()
        viewModel.injectDependency(device: camera)
    }

    func testDefaultInitialState() {
        XCTAssertFalse(viewModel.isShowingImagePicker)
        XCTAssertFalse(viewModel.hasSelectedImage)
        XCTAssertNil(viewModel.selectedImage)
    }

    func testTakePicture() {
        viewModel.takePicture()
        XCTAssertFalse(viewModel.isShowingImagePicker)
        XCTAssert(viewModel.hasSelectedImage)
        XCTAssertNotNil(viewModel.selectedImage)
    }

    func testBackFromImagePickerDidNotSelectImage() {
        viewModel.isShowingImagePicker = true
        viewModel.backFromImagePicker(hasSelectedImage: false, image: nil)
        XCTAssertFalse(viewModel.isShowingImagePicker)
        XCTAssertFalse(viewModel.hasSelectedImage)
        XCTAssertNil(viewModel.selectedImage)
    }

    func testBackFromImagePickerSelectedImage() {
        viewModel.isShowingImagePicker = true
        viewModel.backFromImagePicker(hasSelectedImage: true, image: UIImage())
        XCTAssertFalse(viewModel.isShowingImagePicker)
        XCTAssertTrue(viewModel.hasSelectedImage)
        XCTAssertNotNil(viewModel.selectedImage)
    }
}
