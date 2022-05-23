import SwiftUI

struct WADButton: View {
    var text: String
    var icon: Image?
    var clicked: () -> Void // use closure for callback

    var body: some View {
        Button(action: clicked) { // call the closure here
            HStack {
                icon // your icon image

                Text(text)
                    .font(Font.custom("SF Pro Rounded", size: 17))
                    .fontWeight(.semibold) // your text
            }
            .foregroundColor(Color("WADgreen2"))
            .padding()
            .background(Color("WADgray2"))
            .cornerRadius(10)
        }
    }
}

struct ButtonPreviews: PreviewProvider {
    static var previews: some View {
        WADButton(
            text: "Custom Button",
            icon: Image(systemName: "plus")
        ) {
            print("Clicked!")
        }
    }
}
