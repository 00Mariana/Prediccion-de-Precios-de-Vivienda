# Prediccion de Precios de Vivienda

A machine learning model that predicts house sale prices based on attributes like size, location, and available services.

## Project Structure

```
├── data/
│   ├── raw/                    # Original dataset from Kaggle
│   └── processed/              # Cleaned dataset
├── notebooks/
│   ├── 01_recopilacion_datos.ipynb   # SMART 1: Data collection & exploration
│   ├── 02_limpieza_datos.ipynb       # SMART 2: Data cleaning
│   ├── 03_entrenamiento.ipynb        # SMART 3: Model training
│   └── 04_comparacion.ipynb          # SMART 4: Model comparison
├── src/
│   ├── data_processing.py      # Data cleaning functions
│   ├── model_training.py       # Model training functions
│   └── evaluation.py           # Evaluation metrics
├── models/                     # Saved trained models
├── api/                        # FastAPI REST API
│   ├── main.py                 # API entry point
│   ├── schemas.py              # Pydantic models
│   └── model.py                # Prediction logic
├── tests/                      # API tests
└── requirements.txt
```

## Dataset

[House Prices - Advanced Regression Techniques](https://www.kaggle.com/c/house-prices-advanced-regression-techniques) from Kaggle.

- 1460 rows, 79 features
- Target: `SalePrice`

## Setup

1. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

2. Download `train.csv` from Kaggle and place it in `data/raw/`

3. Run notebooks in order (01 -> 02 -> 03 -> 04)

## SMART Goals

| SMART | Task | Owner | Deadline |
|-------|------|-------|----------|
| 1 | Data Collection | Maria | Week 2 July |
| 2 | Data Cleaning | Maria | Week 3 July |
| 3 | Model Training | Teammate | Week 4 July |
| 4 | Model Comparison | Teammate | Week 1 August |
| 5 | REST API | Teammate | August 10 |
