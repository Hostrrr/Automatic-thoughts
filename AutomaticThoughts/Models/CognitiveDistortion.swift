import Foundation

enum CognitiveDistortion: String, CaseIterable, Identifiable, Codable {
    case catastrophizing
    case allOrNothing
    case mindReading
    case overgeneralization
    case personalization
    case shouldStatements
    case fortuneTelling
    case emotionalReasoning
    case mentalFilter
    case disqualifyingPositive
    case magnificationMinimization
    case labeling
    case blaming
    case controlFallacy
    case fairnessFallacy
    case alwaysBeingRight
    case comparison

    var id: String { rawValue }

    var title: String {
        switch self {
        case .catastrophizing: return "Катастрофизация"
        case .allOrNothing: return "Чёрно-белое мышление"
        case .mindReading: return "Чтение мыслей"
        case .overgeneralization: return "Сверхобобщение"
        case .personalization: return "Персонализация"
        case .shouldStatements: return "Долженствование"
        case .fortuneTelling: return "Предсказание будущего"
        case .emotionalReasoning: return "Эмоциональное обоснование"
        case .mentalFilter: return "Ментальный фильтр"
        case .disqualifyingPositive: return "Дисквалификация позитива"
        case .magnificationMinimization: return "Преувеличение и преуменьшение"
        case .labeling: return "Навешивание ярлыков"
        case .blaming: return "Обвинительное мышление"
        case .controlFallacy: return "Иллюзия контроля"
        case .fairnessFallacy: return "Ложная справедливость"
        case .alwaysBeingRight: return "Необходимость быть правым"
        case .comparison: return "Сравнение с другими"
        }
    }
}
