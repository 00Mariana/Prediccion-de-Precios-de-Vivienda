# AGENTS.md — Project Summary

## Project: Predicción de Precios de Vivienda

**Goal:** Predict house sale prices using ML (79 features, Ames Iowa dataset from Kaggle).

---

## SMART Goals

| SMART | Task | Owner | Status |
|-------|------|-------|--------|
| 1 | Data Collection | Maria | IN PROGRESS |
| 2 | Data Cleaning | Maria | IN PROGRESS |
| 3 | Model Training | Teammate | NOT STARTED |
| 4 | Model Comparison | Teammate | NOT STARTED |
| 5 | REST API (FastAPI) | Teammate | NOT STARTED |

---

## Tech Stack

pandas, numpy, scikit-learn, matplotlib, seaborn, FastAPI, uvicorn, Pydantic, joblib

## Dataset

`data/raw/train.csv` — 1460 rows, 79 features, target = `SalePrice`.
Download from Kaggle (requires login): `kaggle.com/c/house-prices-advanced-regression-techniques/data`

---

## Project Structure

```
data/raw/train.csv              ← Downloaded from Kaggle ✓
data/processed/                 ← Output after SMART 2
notebooks/
  01_recopilacion_datos.ipynb   ← DONE (SMART 1)
  02_limpieza_datos.ipynb       ← DONE (SMART 2)
  03_entrenamiento.ipynb        ← Empty placeholder
  04_comparacion.ipynb          ← Empty placeholder
src/
  data_processing.py            ← DONE (SMART 2 helper functions)
  model_training.py             ← Empty placeholder
  evaluation.py                 ← Empty placeholder
models/                         ← Empty
api/main.py, schemas.py, model.py  ← Empty placeholders
tests/test_api.py               ← Empty placeholder
requirements.txt, .gitignore, README.md  ← Done
```

---

## What's Built So Far

### SMART 1 — `01_recopilacion_datos.ipynb`
- Loads `data/raw/train.csv`
- Shows `.info()`, `.describe()`, `.shape`
- Plots SalePrice distribution (normal + log)
- Missing values analysis (count + %)
- Numerical/categorical column breakdown
- Correlation heatmap (top features vs SalePrice)
- Scatter plots (GrLivArea, TotalBsmtSF, GarageArea, YearBuilt, OverallQual vs SalePrice)
- Saves summary to `data/raw/dataset_summary.txt`

### SMART 2 — `02_limpieza_datos.ipynb` + `src/data_processing.py`
- **Functions:** `load_data()`, `handle_nulls(threshold=0.4)`, `encode_categoricals()`, `remove_outliers(column, iqr_multiplier=1.5)`, `preprocess_pipeline()`
- Drops Id column
- Drops columns with >40% nulls
- Fills remaining nulls: median (numeric), mode (categorical)
- Removes outliers using IQR on SalePrice
- One-hot encodes with sklearn `OneHotEncoder` (saves encoder to `models/encoder.joblib` for API reuse)
- Saves cleaned data to `data/processed/train_clean.csv`

---

## Key Decisions

- **Encoding:** sklearn `OneHotEncoder` (not pd.get_dummies) — reusable in API
- **Outlier threshold:** IQR multiplier 1.5 (standard)
- **API:** FastAPI (auto-docs, type validation, easy deployment)
- **API features:** Top ~15 most important (determined after training)
- **Notebook language:** All markdown cells in **English**

---

## What's Left to Build

- **SMART 3 (notebook + src/model_training.py):** Train Decision Tree, Random Forest, Ridge, Lasso, Gradient Boosting. Target R² > 0.80
- **SMART 4 (notebook + src/evaluation.py):** Compare models, bar charts, residual plots, feature importance, save best model
- **SMART 5 (api/):** FastAPI POST /predict endpoint, ~15 key features, Pydantic validation, load model + encoder, return predicted price

---

## How to Run

```bash
pip install -r requirements.txt
pip install jupyter
jupyter notebook
# Open notebooks/01_recopilacion_datos.ipynb → Run all
# Open notebooks/02_limpieza_datos.ipynb → Run all
```

---

## Note for Next Session

`train.csv` is already in `data/raw/`. Notebooks 01 and 02 are ready to run. User needs to run them, then continue with SMART 3-5 or help teammates.
