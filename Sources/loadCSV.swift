//
//  loadCSV.swift
//  UnireClassification
//
//  Created by Rapha Vidal on 07/02/25.
//

import Foundation
import SwiftCSV
import MLX


//struct MLXData {
//    let features: MLXArray
//    let label: MLXArray
//}

func loadCSVData(_ fileName: String) -> (features: [[Double]], label: [Double])? {
    print("Carregando (fileName).csv...")
    
    //Verificar se o arquivo CSV existe
    guard let fileURL = Bundle.module.url(forResource: fileName, withExtension: "csv") else {
        print(" Arquivo CSV '(fileName).csv' não encontrado.")
        return nil
    }

    do {
        // Ler o conteúdo do arquivo CSV
        let contents = try String(contentsOf: fileURL, encoding: .utf8)
        let lines = contents.components(separatedBy: "\r\n").dropFirst()
        
        print("CSV carregado com (csv.rows.count) linhas.")

        // Arrays para armzenar os dados
        var features: [[Double]] = []
        var labels: [Double] = []
        
        // Pprocessar as linhas
        for line in lines {
            let columns = line.components(separatedBy: ",")
            if columns.count == 4 {
                // Converter as 3 primeiras colunas para Float(RBG)
                let red = Double(columns[0]) ?? 0
                let green = Double(columns[1]) ?? 0
                let blue = Double(columns[2]) ?? 0
                features.append([red, green, blue])
                
                // Converter a última coluna para Float (classification)
                var classification: Double {
                    switch columns[3] {
                        case "Transparente":
                            return 0
                        case "Hidratado":
                            return 1
                        case "Moderado":
                            return 2
                        case "Desidratado":
                            return 3
                        case "Muito desidratado":
                            return 4
                        case "Anormal":
                            return 5
                        default:
                            return 6
                    }
                }
                labels.append(classification)
            }
        }
        
        print("Dados carregados com sucesso.")

        return (features, labels)
    } catch {
        print(" Erro ao carregar o CSV: (error)")
        return nil
    }
}
