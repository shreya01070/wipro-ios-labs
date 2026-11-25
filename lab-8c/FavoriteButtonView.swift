
import SwiftUI

struct FavoriteButtonView: View {

    @Binding var isFavorite: Bool

    var body: some View {

        Button {

            isFavorite.toggle()

        } label: {

            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.system(size: 21))
                .foregroundColor(isFavorite ? .red : .gray)
                .padding(8)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(
            isFavorite ? "Remove from favourites" : "Add to favourites"
        )
    }
}

#Preview {
    FavoriteButtonView(isFavorite: .constant(false))
}
