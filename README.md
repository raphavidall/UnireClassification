# UrineClassification

## Descrição do Projeto
O **UrineClassification** é um projeto acadêmico que tem como objetivo classificar o nível de hidratação de uma pessoa com base na cor da sua urina. A cor da urina é fornecida como um valor RGB (Red, Green, Blue), e os modelos de Machine Learning **KNN (K-Nearest Neighbors)** e **DMC (Distância Mínima ao Centróide)** são utilizados para prever a classificação da hidratação.

O projeto visa estudar e comparar o desempenho desses dois algoritmos de aprendizado supervisionado na tarefa de classificação.

---

## Objetivos
- Implementar e compreender o funcionamento do algoritmo KNN.
- Implementar e compreender o funcionamento do algoritmo DMC.
- Classificar o nível de hidratação com base em uma cor RGB fornecida.
- Comparar o desempenho dos dois modelos em termos de acurácia.

---

## Funcionamento
O sistema recebe como entrada uma cor no formato RGB (por exemplo, `[255, 200, 150]`) e retorna uma classificação do nível de hidratação, que pode ser:
- **Excesso de Água ou Condição Adversa**
- **Hidratado**
- **Levemente Desidratado**
- **Desidratado**
- **Muito Desidratado**
- **Desidratação Severa ou Condição Adversa**


A classificação é feita com base em um conjunto de dados pré-processado que mapeia cores de urina para níveis de hidratação.

---

## Tecnologias Utilizadas
- **Swift**: Linguagem de programação principal.
- **MLX-Swift**: Biblioteca para implementação dos modelos KNN e DMC.

---

## Como Executar o Projeto

### Instalação
1. Clone o repositório:
   ```bash
   git clone https://github.com/raphavidall/UrineClassification.git
   cd UrineClassification
   ```

2. Execute o projeto no XCode:
   ```bash
   Command + R
   ```
---

## Estrutura do Projeto
```
UrineClassification/
├── Resources/                   # Pasta contendo os conjuntos de dados
│   └── urine_colors.csv      # Arquivo CSV com os dados de cores e hidratação
├── Sources/                    # Pasta com scripts Python
│   ├── main.swift        # Execução dos Modelos
│   ├── utils.swift        # Funções dos Modelos
│   └── loadCSV.py        # Função para leitura dos dados no formato csv
└── README.md               # Este arquivo
```

---

## Exemplo de Uso
Após treinar os modelos, você pode classificar o nível de hidratação a partir de uma cor RGB da seguinte forma:

```swift
# Exemplo de entrada
cor_rgb = [255, 200, 150]

# Classificação usando KNN
classificacao_knn = knn_model.predict([cor_rgb])
print(f"Classificação KNN: {classificacao_knn}")

# Classificação usando DMC
classificacao_dmc = dmc_model.predict([cor_rgb])
print(f"Classificação DMC: {classificacao_dmc}")
```

---

## Resultados Esperados
- Comparação das métricas de desempenho entre KNN e DMC.

---

## Contribuição
Este é um projeto acadêmico, mas contribuições e sugestões são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests.

---

## Contato
- **Autor**: [Raphaela Vidal]
- **E-mail**: [rapha.vidall@gmail.com]
- **Repositório**: [GitHub](https://github.com/raphavidall/UrineClassification)

---
