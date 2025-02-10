//
//  Train.swift
//  UnireClassification
//
//  Created by Rapha Vidal on 09/02/25.
//
import MLX
import MLXLinalg

// Embaralhar e Dividir dados em treinamento e testes
func shuffleAndSplitData(features: MLXArray, labels: MLXArray, trainRatio: Double = 0.8) -> (xTrain: MLXArray, yTrain: MLXArray, xTest: MLXArray, yTest: MLXArray)? {
    let numSamples = features.shape[0]
    
    // Verificar se há dados suficientes
    guard numSamples > 0 else {
        print("Nenhum dado disponível para embaralhar e dividir.")
        return nil
    }
    
    // Gerar índices embaralhados
    let shuffledIndices = (0..<numSamples).shuffled()
    
    // Dividir os índices em treino e teste
    let splitIndex = Int(Double(numSamples) * trainRatio)
    
    // Converter os índices embaralhados para MLXArray
    let trainIndices = MLXArray(shuffledIndices[0..<splitIndex].map { Int32($0) })
    let testIndices = MLXArray(shuffledIndices[splitIndex..<numSamples].map { Int32($0) })
    
    // Extrair os dados embaralhados usando take
    let xTrain = features.take(trainIndices, axis: 0)
    let yTrain = labels.take(trainIndices, axis: 0)
    let xTest = features.take(testIndices, axis: 0)
    let yTest = labels.take(testIndices, axis: 0)
    
    return (xTrain, yTrain, xTest, yTest)
}

// Classificar Urina (KNN)
func UrineClassificationKnn(xTrain: MLXArray, yTrain: MLXArray, xTest: MLXArray, yTest: MLXArray, k: Int) -> String {
    
    var correctPredictions = 0
        
        // Iterar sobre cada amostra de teste
        for i in 0..<xTest.shape[0] {
            let testSample = xTest[i]
            
            // Calcular distâncias entre a amostra de teste e todas as amostras de treino
            let distances = norm(xTrain - testSample, axes: [1])
            
            // Encontrar os k vizinhos mais próximos
            let indices = argSort(distances)[..<k]
            let neighborLabels = yTrain[indices].asArray(Int.self)
            
            // Contar a frequência de cada label entre os vizinhos
            var labelCounts = [Int: Int]()
            for label in neighborLabels {
                labelCounts[label] = (labelCounts[label] ?? 0) + 1
            }
            
            // Prever o label com a maior contagem
            let prediction = labelCounts.max { $0.value < $1.value }!.key
            
            // Verificar se a previsão está correta
            let trueLabel = yTest[i].item(Int.self)
            if prediction == trueLabel {
                correctPredictions += 1
            }
            
            print("Amostra \(i): Previsão = \(prediction), Verdadeiro = \(trueLabel)")
        }
        
        // Calcular a precisão
        let accuracy = Float(correctPredictions) / Float(yTest.shape[0]) * 100
        print("Precisão: \(accuracy)%")
        
        return "Precisão: \(accuracy)%"
    
}

// Classificar Urina (DMC)
func UrineClassificationDmc(xTrain: MLXArray, yTrain: MLXArray, xTest: MLXArray, yTest: MLXArray) -> String {
    var correctPredictions = 0
    
    // Calcular os centróides de cada classe
    let centroids = calculateCentroids(xTrain: xTrain, yTrain: yTrain)
    
    // Iterar sobre cada amostra de teste
    for i in 0..<xTest.shape[0] {
        let testSample = xTest[i]
        
        // Calcular distâncias entre a amostra de teste e todos os centróides
        var minDistance = Double.infinity
        var predictedLabel = -1
        
        for (label, centroid) in centroids {
            // Calcular a distância Euclidiana
            let diff = testSample - centroid
            let distance = norm(diff).item(Float.self) // Extrair o valor escalar da distância
                    
            // Encontrar o centróide mais próximo
            if Double(distance) < minDistance {
                    minDistance = Double(distance)
                    predictedLabel = label
                }
            }
        
            // Verificar se a previsão está correta
            let trueLabel = yTest[i].item(Int.self)
            if predictedLabel == trueLabel {
                correctPredictions += 1
            }
        
        print("Amostra \(i): Previsão = \(predictedLabel), Verdadeiro = \(trueLabel)")
    }
    
    // Calcular a precisão
    let accuracy = Float(correctPredictions) / Float(yTest.shape[0]) * 100
    print("Precisão: \(accuracy)%")
    
    return "Precisão: \(accuracy)%"
}

// Função para calcular os centróides de cada classe
func calculateCentroids(xTrain: MLXArray, yTrain: MLXArray) -> [Int: MLXArray] {
    var centroids = [Int: MLXArray]()
    var classCounts = [Int: Int]()
    
    // Iterar sobre cada amostra de treino
    for i in 0..<xTrain.shape[0] {
        let sample = xTrain[i]
        let label = yTrain[i].item(Int.self)
        
        // Somar as features para cada classe
        if centroids[label] == nil {
            centroids[label] = sample
        } else {
            centroids[label]! += sample
        }
        
        // Contar o número de amostras por classe
        classCounts[label] = (classCounts[label] ?? 0) + 1
    }
    
    // Calcular a média (centróide) para cada classe
    for (label, sumFeatures) in centroids {
        centroids[label] = sumFeatures / Double(classCounts[label]!)
    }
    
    print("Centroides: ", centroids)
    
    return centroids
}
