import SwiftUI

// Update to BubbleStyle
struct BubbleStyle {
    // Colors
    static let accentColor = Color.blue // The circular button is more blue than the original 4A55A2
    static let backgroundColor = Color.white
    static let textPrimaryColor = Color.black
    static let textSecondaryColor = Color.gray.opacity(0.6)
    static let underlineColor = Color.gray.opacity(0.2)
    static let borderColor = Color.gray.opacity(0.3)
    
    // Fonts
    static let headerFont: Font = .system(size: 28, weight: .bold) // Headers appear larger and bolder
    static let bodyFont: Font = .system(size: 16)
    static let captionFont: Font = .system(size: 12)
    static let caption2Font: Font = .system(size: 10)
    
    // Button dimensions
    static let nextButtonWidth: CGFloat = 44
    static let nextButtonHeight: CGFloat = 44
    
    // Spacing
    static let standardPadding: CGFloat = 24
    static let topPadding: CGFloat = 40
    static let inputSpacing: CGFloat = 24 // Increased spacing between inputs
    
    // Text field
    static let textFieldHeight: CGFloat = 40
    static let underlineHeight: CGFloat = 1
}

// Updated UnderlinedTextField
struct UnderlinedTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var textAlignment: TextAlignment = .leading
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .multilineTextAlignment(textAlignment)
                .font(BubbleStyle.bodyFont)
                .frame(height: BubbleStyle.textFieldHeight)
            
            Rectangle()
                .frame(height: BubbleStyle.underlineHeight)
                .foregroundColor(BubbleStyle.underlineColor)
        }
    }
}

// Updated NextButton
struct NextButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.right")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: BubbleStyle.nextButtonWidth, height: BubbleStyle.nextButtonHeight)
                .background(BubbleStyle.accentColor)
                .clipShape(Circle())
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.bottom, 40)
    }
}

// DottedBorder modifier for image upload
struct DottedBorder: ViewModifier {
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(style: StrokeStyle(
                    lineWidth: 1,
                    dash: [4]
                ))
                .foregroundColor(BubbleStyle.borderColor)
        )
    }
}
// MARK: - Input Name View
struct InputNameView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @Binding var currentPage: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: BubbleStyle.standardPadding) {
            Text("What's your name?")
                .font(BubbleStyle.headerFont)
                .padding(.top, BubbleStyle.topPadding)
            
            VStack(alignment: .leading, spacing: BubbleStyle.inputSpacing) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("First name (required)")
                        .font(.caption)
                        .foregroundColor(BubbleStyle.textSecondaryColor)
                    
                    UnderlinedTextField(placeholder: "", text: $firstName)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Last name")
                        .font(.caption)
                        .foregroundColor(BubbleStyle.textSecondaryColor)
                    
                    UnderlinedTextField(placeholder: "", text: $lastName)
                    
                    Text("Last name will never be visible. Why?")
                        .font(.caption2)
                        .foregroundColor(BubbleStyle.textSecondaryColor)
                }
            }
            
            Spacer()
            
            NextButton {
                withAnimation {
                    currentPage += 1
                }
            }
        }
        .padding(.horizontal, BubbleStyle.standardPadding)
        .background(BubbleStyle.backgroundColor)
    }
}

// MARK: - Input Age View
struct InputAgeView: View {
    @State private var day: String = ""
    @State private var month: String = ""
    @State private var year: String = ""
    @Binding var currentPage: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: BubbleStyle.standardPadding) {
            Text("How old are you?")
                .font(BubbleStyle.headerFont)
                .padding(.top, BubbleStyle.topPadding)
            
            HStack(spacing: 8) {
                UnderlinedTextField(placeholder: "DD", text: $day, keyboardType: .numberPad, textAlignment: .center)
                    .frame(width: 60)
                
                Text("/")
                    .foregroundColor(BubbleStyle.textSecondaryColor)
                
                UnderlinedTextField(placeholder: "MM", text: $month, keyboardType: .numberPad, textAlignment: .center)
                    .frame(width: 60)
                
                Text("/")
                    .foregroundColor(BubbleStyle.textSecondaryColor)
                
                UnderlinedTextField(placeholder: "YYYY", text: $year, keyboardType: .numberPad, textAlignment: .center)
                    .frame(width: 80)
            }
            .padding(.top, 20)
            
            Spacer()
            
            NextButton {
                withAnimation {
                    currentPage += 1
                }
            }
        }
        .padding(.horizontal, BubbleStyle.standardPadding)
        .background(BubbleStyle.backgroundColor)
    }
}

// MARK: - Input Height View
struct InputHeightView: View {
    @State private var height: Double = 5.8
    @Binding var currentPage: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: BubbleStyle.standardPadding) {
            Text("How tall are you?")
                .font(BubbleStyle.headerFont)
                .padding(.top, BubbleStyle.topPadding)
            
            VStack(spacing: 40) {
                HeightIndicator(height: height)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                VStack(spacing: 10) {
                    CustomSlider(value: $height, range: 4...7)
                    
                    HeightMarkers()
                }
                
                Text("Height visible on profile.")
                    .font(.caption)
                    .foregroundColor(BubbleStyle.textSecondaryColor)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            Spacer()
            
            NextButton {
                withAnimation {
                    currentPage += 1
                }
            }
        }
        .padding(.horizontal, BubbleStyle.standardPadding)
        .background(BubbleStyle.backgroundColor)
    }
}
struct MBTIPairSelection: View {
    let leftOption: String
    let rightOption: String
    @Binding var selection: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text(leftOption)
                    .font(.system(size: 20))
                    .fontWeight(selection == leftOption ? .bold : .regular)
                    .foregroundColor(selection == leftOption ? .black : Color.gray.opacity(0.3))
                    .onTapGesture {
                        selection = leftOption
                    }
                
                Spacer()
                
                Text(rightOption)
                    .font(.system(size: 20))
                    .fontWeight(selection == rightOption ? .bold : .regular)
                    .foregroundColor(selection == rightOption ? .black : Color.gray.opacity(0.3))
                    .onTapGesture {
                        selection = rightOption
                    }
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray.opacity(0.3))
                .padding(.top, 4)
        }
    }
}

struct InputMBTIView: View {
    @State private var firstSelection: String?
    @State private var secondSelection: String?
    @State private var thirdSelection: String?
    @State private var fourthSelection: String?
    @State private var dontKnow: Bool = false
    @Binding var currentPage: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: BubbleStyle.standardPadding) {
            Text("What's your MBTI?")
                .font(.system(size: 28, weight: .bold))
                .padding(.top, BubbleStyle.topPadding)
            
            VStack(spacing: 32) {
                MBTIPairSelection(
                    leftOption: "E",
                    rightOption: "I",
                    selection: $firstSelection
                )
                
                MBTIPairSelection(
                    leftOption: "S",
                    rightOption: "N",
                    selection: $secondSelection
                )
                
                MBTIPairSelection(
                    leftOption: "T",
                    rightOption: "F",
                    selection: $thirdSelection
                )
                
                MBTIPairSelection(
                    leftOption: "J",
                    rightOption: "P",
                    selection: $fourthSelection
                )
            }
            .padding(.top, 32)
            
            // Centered "I don't know" row
            HStack {
                Spacer()
                Text("I don't know.")
                    .font(.system(size: 16))
                    .foregroundColor(Color.gray.opacity(0.6))
                Toggle("", isOn: $dontKnow)
                    .labelsHidden()
                    .toggleStyle(CheckboxToggleStyle())
                Spacer()
            }
            .padding(.top, 32)
            
            Spacer()
            
            NextButton {
                withAnimation {
                    currentPage += 1
                }
            }
        }
        .padding(.horizontal, BubbleStyle.standardPadding)
        .background(BubbleStyle.backgroundColor)
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                .frame(width: 20, height: 20)
                .background(
                    configuration.isOn ?
                    RoundedRectangle(cornerRadius: 3).fill(Color.blue) :
                    RoundedRectangle(cornerRadius: 3).fill(Color.clear)
                )
                .overlay(
                    configuration.isOn ?
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .font(.system(size: 12, weight: .bold)) :
                    nil
                )
        }
    }
}

// MARK: - Input Gender View
struct InputGenderView: View {
    @State private var selectedGender: Gender = .none
    @State private var visibleOnProfile: Bool = true
    @Binding var currentPage: Int
    
    enum Gender {
        case man, woman, nonbinary, other, none
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: BubbleStyle.standardPadding) {
            Text("Which gender best describes you?")
                .font(BubbleStyle.headerFont)
                .padding(.top, BubbleStyle.topPadding)
            
            VStack(spacing: 16) {
                ForEach([
                    (Gender.man, "Man"),
                    (Gender.woman, "Woman"),
                    (Gender.nonbinary, "Nonbinary"),
                    (Gender.other, "Other")
                ], id: \.0) { gender, title in
                    GenderOptionRow(
                        title: title,
                        isSelected: selectedGender == gender,
                        action: { selectedGender = gender }
                    )
                }
                
                HStack {
                    Text("Visible on profile")
                        .foregroundColor(BubbleStyle.textSecondaryColor)
                    Spacer()
                    Toggle("", isOn: $visibleOnProfile)
                        .labelsHidden()
                }
                .padding(.top, 20)
            }
            
            Spacer()
            
            NextButton {
                withAnimation {
                    currentPage += 1
                }
            }
        }
        .padding(.horizontal, BubbleStyle.standardPadding)
        .background(BubbleStyle.backgroundColor)
    }
}

// MARK: - About Me View
struct AboutMeView: View {
    @State private var aboutText: String = ""
    @Binding var currentPage: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: BubbleStyle.standardPadding) {
            Text("About me")
                .font(BubbleStyle.headerFont)
                .padding(.top, BubbleStyle.topPadding)
            
            ZStack(alignment: .topLeading) {
                if aboutText.isEmpty {
                    Text("A brief introduction about yourself")
                        .foregroundColor(BubbleStyle.textSecondaryColor.opacity(0.8))
                        .padding(.top, 8)
                        .padding(.leading, 4)
                }
                
                TextEditor(text: $aboutText)
                    .frame(height: 120)
                    .padding(4)
                    .background(BubbleStyle.backgroundColor)
                    .cornerRadius(8)
                    .opacity(aboutText.isEmpty ? 0.25 : 1)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(BubbleStyle.borderColor, lineWidth: 1)
            )
            
            Spacer()
            
            NextButton {
                withAnimation {
                    currentPage += 1
                }
            }
        }
        .padding(.horizontal, BubbleStyle.standardPadding)
        .background(BubbleStyle.backgroundColor)
    }
}

// MARK: - Upload Pictures View
struct UploadPicturesView: View {
    @State private var selectedImages: [Image?] = Array(repeating: nil, count: 9)
    @Binding var currentPage: Int
    @Binding var isOnboarding: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: BubbleStyle.standardPadding) {
            Text("Upload pictures")
                .font(BubbleStyle.headerFont)
                .padding(.top, BubbleStyle.topPadding)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3),
                      spacing: 10) {
                ForEach(0..<9) { index in
                    ImageUploadCell(image: selectedImages[index])
                }
            }
            
            Spacer()
            
            NextButton {
                isOnboarding = false
            }
        }
        .padding(.horizontal, BubbleStyle.standardPadding)
        .background(BubbleStyle.backgroundColor)
    }
}

// MARK: - Supporting Views
struct HeightIndicator: View {
    let height: Double
    
    var body: some View {
        Circle()
            .fill(Color(hex: "FFAA77"))
            .frame(width: 24, height: 24)
    }
}

struct CustomSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    
    var body: some View {
        Slider(value: $value, in: range, step: 0.1)
            .accentColor(BubbleStyle.accentColor)
            .padding(.vertical, 10)
    }
}

struct HeightMarkers: View {
    var body: some View {
        HStack {
            ForEach(["4'", "5'", "6'", "7'"], id: \.self) { mark in
                Text(mark)
                    .font(.caption)
                    .foregroundColor(BubbleStyle.textSecondaryColor)
                if mark != "7'" { Spacer() }
            }
        }
    }
}

struct GenderOptionRow: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(BubbleStyle.bodyFont)
                .foregroundColor(BubbleStyle.textPrimaryColor)
            Spacer()
            Circle()
                .stroke(isSelected ? BubbleStyle.accentColor : BubbleStyle.borderColor, lineWidth: 1)
                .frame(width: 20, height: 20)
                .overlay(
                    Circle()
                        .fill(isSelected ? BubbleStyle.accentColor : Color.clear)
                        .frame(width: 14, height: 14)
                )
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: action)
    }
}

struct ImageUploadCell: View {
    let image: Image?
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .frame(height: 100)
                .modifier(DottedBorder())
            
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 100)
                    .clipped()
            } else {
                Image(systemName: "plus")
                    .font(.system(size: 20))
                    .foregroundColor(BubbleStyle.textSecondaryColor)
            }
        }
    }
}

// MARK: - Registration Flow Container
struct RegistrationFlow: View {
    @State private var currentPage: Int = 0
    @Binding var isOnboarding: Bool
    
    var body: some View {
        TabView(selection: $currentPage) {
            InputNameView(currentPage: $currentPage)
                .tag(0)
            
            InputAgeView(currentPage: $currentPage)
                .tag(1)
            
            InputHeightView(currentPage: $currentPage)
                .tag(2)
            
            InputMBTIView(currentPage: $currentPage)
                .tag(3)
            
            InputGenderView(currentPage: $currentPage)
                .tag(4)
            
            AboutMeView(currentPage: $currentPage)
                .tag(5)
            
            UploadPicturesView(currentPage: $currentPage, isOnboarding: $isOnboarding)
                .tag(6)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .background(BubbleStyle.backgroundColor)
    }
}
