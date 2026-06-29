# Prediccion de Precios de Vivienda

 Modelo de machine learning para predecir el precio de venta de una casa basandose en atributos como tamano, ubicacion y servicios disponibles.

## Objetivo

Crear un modelo que pueda predecir el precio de venta de una vivienda utilizando arboles de decision para regresion, permitiendo a personas sin experiencia en bienes raices estimar si un precio es justo.

## Tecnologias

- **Backend:** Python, Scikit-learn, Pandas, NumPy
- **API:** FastAPI
- **Frontend:** Flutter (Dashboard completo)
- **Dataset:** Ames Iowa Housing (Kaggle)

## Estructura

```
├── notebooks/          # Notebooks Jupyter para cada fase
├── src/                # Codigo Python reutilizable
├── api/                # API REST con FastAPI
├── flutter_app/        # Frontend Flutter
├── data/               # Datos crudos y procesados
└── models/             # Modelos entrenados
```

## Equipo

| Miembro | Responsabilidad |
|---------|-----------------|
| Mariana | SMART 1, SMART 2, Frontend Flutter |
| Companero A | SMART 3 (Entrenamiento) |
| Companero B | SMART 5 (API REST) |

## Como Empezar

1. Clonar el repositorio
2. Instalar dependencias: `pip install -r requirements.txt`
3. Descargar dataset de Kaggle y ponerlo en `data/raw/train.csv`
4. Abrir `notebooks/01_recopilacion_datos.ipynb` para empezar
