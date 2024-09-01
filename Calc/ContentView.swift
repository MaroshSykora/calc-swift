
import SwiftUI

struct ContentView: View {
    @State private var value: String = "0"
    @State private var prevValue: String? = nil
    @State private var currentOperator: String? = nil

    func handleButtonClick(symbol: String) {
        if ["+", "-", "x", "÷"].contains(symbol) {
            if value != "0" && !["+", "-", "x", "÷"].contains(value) {
                currentOperator = symbol
                prevValue = value
                value = symbol
            }
        } else if symbol == "." {
            if !value.contains(".") {
                value += "."
            }
        } else if symbol != "=" {
            if value == "0" || ["+", "-", "x", "÷"].contains(value) {
                value = symbol
            } else {
                value += symbol
            }
        }
    }

    func handleResult() {
        if let op = currentOperator, let prev = prevValue, let num1 = Double(prev), let num2 = Double(value) {
            let result: Double
            switch op {
            case "+":
                result = num1 + num2
            case "-":
                result = num1 - num2
            case "x":
                result = num1 * num2
            case "÷":
                result = num2 != 0 ? num1 / num2 : Double.nan
            default:
                result = 0
            }
            value = result.isNaN ? "Error" : String(result)
            prevValue = nil
            currentOperator = nil
        }
    }

    func handleReset() {
        value = "0"
        prevValue = nil
        currentOperator = nil
    }

    var body: some View {
        ZStack {
            Color(red: 58/255, green: 83/255, blue: 44/255)
                .ignoresSafeArea()

            VStack(spacing: 10) {
                Text("Kalkulačka")
                    .font(.system(size: 50, weight: .regular, design: .monospaced))
                    .foregroundColor(.white)
                    .padding()

                VStack(spacing:4) {
                    Text(value)
                        .font(.system(size: 50, weight: .regular))
                        .frame(maxWidth: 350, alignment: .trailing)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color(hex: "#3a532c"))
                        .cornerRadius(15)

                    Grid(horizontalSpacing: 1, verticalSpacing: 1) {
                        GridRow {
                            Button("C", action: handleReset)
                                .buttonStyle(CalculatorButtonStyle(area: .lightGreen))
                                .gridCellColumns(3) // Tlačítko "C" zabere 3 sloupce
                                .background(Color(hex: "#7dc814"))
                            Button("÷") { handleButtonClick(symbol: "÷") }
                                .buttonStyle(CalculatorButtonStyle(area: .darkGreen))
                        }
                        GridRow {
                            Button("7") { handleButtonClick(symbol: "7") }
                                .buttonStyle(CalculatorButtonStyle(area: .lightGreen))
                            Button("8") { handleButtonClick(symbol: "8") }
                                .buttonStyle(CalculatorButtonStyle(area: .lightGreen))
                            Button("9") { handleButtonClick(symbol: "9") }
                                .buttonStyle(CalculatorButtonStyle(area: .lightGreen))
                            Button("x") { handleButtonClick(symbol: "x") }
                                .buttonStyle(CalculatorButtonStyle(area: .darkGreen))
                        }
                        GridRow {
                            Button("4") { handleButtonClick(symbol: "4") }
                                .buttonStyle(CalculatorButtonStyle(area: .lightGreen))
                            Button("5") { handleButtonClick(symbol: "5") }
                                .buttonStyle(CalculatorButtonStyle(area: .lightGreen))
                            Button("6") { handleButtonClick(symbol: "6") }
                                .buttonStyle(CalculatorButtonStyle(area: .lightGreen))
                            Button("-") { handleButtonClick(symbol: "-") }
                                .buttonStyle(CalculatorButtonStyle(area: .darkGreen))
                        }
                        GridRow {
                            Button("1") { handleButtonClick(symbol: "1") }
                                .buttonStyle(CalculatorButtonStyle(area: .lightGreen))
                            Button("2") { handleButtonClick(symbol: "2") }
                                .buttonStyle(CalculatorButtonStyle(area: .lightGreen))
                            Button("3") { handleButtonClick(symbol: "3") }
                                .buttonStyle(CalculatorButtonStyle(area: .lightGreen))
                            Button("+") { handleButtonClick(symbol: "+") }
                                .buttonStyle(CalculatorButtonStyle(area: .darkGreen))
                        }
                        GridRow {
                            Button("0") { handleButtonClick(symbol: "0") }
                                .gridCellColumns(2)
                                .buttonStyle(CalculatorButtonStyle(area: .lightGreen))
                            Button(".") { handleButtonClick(symbol: ".") }
                                .buttonStyle(CalculatorButtonStyle(area: .lightGreen))
                            Button("=") { handleResult() }
                                .buttonStyle(CalculatorButtonStyle(area: .darkGreen))
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .font(.system(size: 40, design: .monospaced))
                }
                .frame(maxWidth: 350, maxHeight: 450)
            }
        }
    }
}

struct CalculatorButtonStyle: ButtonStyle {
    enum Area {
        case darkGreen, lightGreen
    }
        

    let area: Area

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 40))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(area == .darkGreen ? (Color(hex: "#549e00")) : (Color(hex: "#7dc814")))
            .foregroundColor(.white)
            .cornerRadius(1)
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
