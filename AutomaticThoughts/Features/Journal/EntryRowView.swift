import SwiftUI

struct EntryRowView: View {
    let entry: ThoughtEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text(displayThought)
                    .font(.headline)
                    .lineLimit(2)
                Spacer(minLength: 8)
                if entry.isDraft {
                    Text("Дозаполнить")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.tertiary, in: Capsule())
                        .accessibilityLabel("Черновик, нужно дозаполнить")
                }
            }

            if !entry.event.isEmpty {
                Text(entry.event)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Text(entry.createdAt, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 2)
    }

    private var displayThought: String {
        let thought = entry.automaticThought.trimmingCharacters(in: .whitespacesAndNewlines)
        return thought.isEmpty ? "Без мысли" : thought
    }
}

#Preview {
    List {
        EntryRowView(
            entry: ThoughtEntry(
                event: "Совещание",
                automaticThought: "Я сейчас всё испорчу.",
                isDraft: true
            )
        )
        EntryRowView(
            entry: ThoughtEntry(
                event: "Письмо коллеге",
                automaticThought: "Лучше промолчать.",
                isDraft: false
            )
        )
    }
}
