// Create for Raphaela Vidal

import MLX

print("Welcome to Urine Classification! \nThis program will train a machine learning model to classify urine colors.\n")

// Carregar dados de treinamento e teste
let (features, labels) = loadCSVData("urine_colors") ?? ([[0,0,0]], [0])

// Contar o total de linhas (RBG, classification) que há no banco de dados
let dataLinesCount = features.count

// Achatar o array RBG em unidimensional e converter para MLXArray
// [[1, 2, 3], [4, 5, 6]] -> [1, 2, 3, 4, 5, 6] -> [[1, 2, 3], [4, 5, 6]]
let flattenedFeatures = features.flatMap(\.self)
let featuresArray = MLXArray(converting: flattenedFeatures).reshaped([dataLinesCount, 3])
let labelsArray = MLXArray(converting: labels)

//Definir a quantidade de k vizinhos
let k = 3

// Emabaralhar e Dividir dados para treino e testes
guard let (xTrain, yTrain, xTest, yTest) = shuffleAndSplitData(features: featuresArray, labels: labelsArray) else {
    fatalError("Não foi possível dividir os dados de treino e teste.")
}

// Executar treino e classificação dos testes
let resultKnn = UrineClassificationKnn(xTrain: xTrain, yTrain: yTrain , xTest: xTest, yTest: yTest, k: k)
let resultDmc = UrineClassificationDmc(xTrain: xTrain, yTrain: yTrain, xTest: xTest, yTest: yTest)
