//
//  ColorPhotoView.swift
//  DentalHealthApp
//
//  Created by Pavel Vyaltsev.
//

import SwiftUI

struct ColorPhotoView: View {
    @State private var showSheet: Bool = false
    @State private var showApproveButton: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera

    @State private var image: UIImage?
    @State private var approvedImages: [UIImage] = []

    @State private var header: String = "Сфотографируйте полную улыбку"
    @State private var description: String = "Убедитесь, что на фотографии изображены все зубы и видна задняя часть рта."

    @StateObject private var viewModel = AnalysisViewModel()


    private func updateData() {
        switch self.approvedImages.count {
        case 0:
            self.header = "Сфотографируйте полную улыбку"
            self.description = "Убедитесь, что на фотографии изображены все зубы и видна задняя часть рта."
        case 1:
            self.header = "Сфотографируйте ротовую полость"
            self.description = "Убедитесь, что на фотографии видна все ваши зубы. Лучше всего будет сфотографировать открытый рот со вспышкой."
        case 2:
            self.header = "Проводим проверку и анализ ваших фото"
            self.description = "Пожалуйста, не закрывайте приложение до окончания анализа."
            viewModel.performAnalysis(type: "color", images: approvedImages)

        default:
            self.header = ""
            self.description = ""
        }
    }

    private var headerAndDescription: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(approvedImages.count < 2 ? "Шаг \(approvedImages.count + 1) из 2" : "")
                .bold()
            Text(header)
                .font(.title)
                .fontWeight(.semibold)
            Text(description)
        }
        .padding([.leading, .trailing], 20)
        .padding(.bottom, 20)
        .onAppear {
            updateData()
        }
    }


    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                headerAndDescription
                if approvedImages.count < 2 {
                    Image(uiImage: image != nil ? image! : UIImage(named: "placeholder")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding([.leading, .trailing, .bottom], 20)
                    Button(action: {
                        //stepNum += 1
                        showSheet = true
                    }) {
                        Text("Добавить фото")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.splatRed)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding([.leading, .trailing], 20)
                    }
                    .actionSheet(isPresented: $showSheet) {
                        ActionSheet(title: Text("Select photo"),
                        message: Text("Choose"), buttons: [
                            .default(Text("Photo Library")) {
                                self.showImagePicker = true
                                self.sourceType = .photoLibrary
                            },
                            .default(Text("Camera")) {
                                self.showImagePicker = true
                                self.sourceType = .camera
                            },
                            .cancel()
                        ])
                    }
                    if showApproveButton {
                        Button(action: {
                            if let uiImage = image {
                                approvedImages.append(uiImage)
                                showApproveButton = false
                                image = nil
                                updateData()
                            }
                        }) {
                            Text("Далее")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.splatRed)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding([.leading, .trailing], 20)
                        }
                    }
                } else if approvedImages.count == 2 {
                    AnalisysView()
                }
                Spacer()
            }
        }
        .navigationTitle("Анализ")
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType) {
                showApproveButton = true
                updateData()
            }
        }
        .sheet(isPresented: $viewModel.showResultScreen) {
            ResultsView(result: $viewModel.analysisResult.wrappedValue)
        }
    }
}

struct ColorPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPhotoView()
    }
}
