// InfoPanelView.swift
import SwiftUI
 
struct InfoPanelView: View {
    let shape: ShapeType
    @Binding var isVisible: Bool
 
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(shape.rawValue.capitalized)
                    .font(.largeTitle)
 
                Spacer()
 
                Button(action: {
                    isVisible = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.largeTitle)
                }
            }
 
            Text("Formulas:")
                .font(.headline)
 
            Text(shape.formulas)
                .font(.system(.body, design: .monospaced))
 
            Divider()
 
            Text("Properties:")
                .font(.headline)
 
            Group {
                switch shape {
                case .cube:
                    Text("- 6 square faces\n- 12 edges\n- 8 vertices")
                case .pyramid:
                    Text("- Polygonal base\n- Triangular sides\n- Apex vertex")
                case .cone:
                    Text("- Circular base\n- Curved surface\n- Apex vertex")
                case .sphere:
                    Text("- Perfectly symmetrical\n- No edges or vertices\n- Constant curvature")
                case .cylinder:
                    Text("- Two parallel bases\n- Curved lateral surface\n- Constant cross-section")
                }
            }
        }
        .padding()
        .frame(width: 400)
        .background(.regularMaterial)
        .cornerRadius(20)
        .padding()
    }
}
