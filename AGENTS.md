# AGENTS.md - Guia para el equipo

## Estructura del Proyecto

```
Prediccion-de-Precios-de-Vivienda/
├── notebooks/                    # Jupyter notebooks para cada fase
│   ├── 01_recopilacion_datos.ipynb   ← SMART 1 (Mariana)
│   ├── 02_limpieza_datos.ipynb       ← SMART 2 (Mariana)
│   ├── 03_entrenamiento.ipynb        ← SMART 3 (Companero A)
│   └── 04_comparacion_modelos.ipynb  ← SMART 4 (Companero A/B)
│
├── src/                          # Codigo Python reutilizable
│   ├── data_processing.py            ← SMART 1 y 2 (Mariana) - YA CREADO
│   ├── model_training.py             ← SMART 3 (Companero A) - POR COMPLETAR
│   └── evaluation.py                 ← SMART 4 (Companero A/B) - POR COMPLETAR
│
├── api/                          # API REST (FastAPI)
│   ├── main.py                       ← SMART 5 (Companero B)
│   ├── model.py                      ← SMART 5 (Companero B)
│   └── schemas.py                    ← SMART 5 (Companero B)
│
├── data/
│   ├── raw/                      # Dataset crudo (no subir a git)
│   └── processed/                # Dataset limpio
│
├── models/                       # Modelos entrenados (no subir a git)
│
├── flutter_app/                  # Frontend en Flutter (Mariana)
│   ├── lib/
│   │   ├── main.dart
│   │   ├── screens/
│   │   ├── widgets/
│   │   └── services/
│   └── pubspec.yaml
│
└── tests/                        # Tests
```

---

## Responsabilidades

### Mariana (Tu) - SMART 1, SMART 2 y Frontend Flutter

**SMART 1 - Recopilacion de Datos** (2da semana de julio):
- [x] Estructura del notebook creada
- [ ] Descargar dataset de Kaggle
- [ ] Completar exploracion de datos
- [ ] Documentar hallazgos

**SMART 2 - Limpieza de Datos** (3ra semana de julio):
- [x] Estructura del notebook creada
- [x] Funciones en `src/data_processing.py` creadas
- [ ] Probar las funciones con el dataset real
- [ ] Guardar dataset limpio en `data/processed/`

**Frontend Flutter**:
- [x] Estructura basica creada
- [ ] Completar `DashboardScreen` con metricas reales
- [ ] Completar `PredictionScreen` con todos los campos del modelo
- [ ] Completar `ComparisonScreen` con graficas reales
- [ ] Conectar `ApiService` con la API cuando este lista

---

### Companero A - SMART 3 (Entrenamiento)

**SMART 3 - Entrenamiento del Modelo** (4ta semana de julio):

**Que hacer:**
1. Abrir `notebooks/03_entrenamiento.ipynb`
2. Cargar el dataset limpio: `pd.read_csv('../data/processed/train_clean.csv')`
3. Dividir en train/test (80/20)
4. Entrenar 3 modelos de `DecisionTreeRegressor`:
   - `criterion='squared_error'`
   - `criterion='friedman_mse'`
   - `criterion='poisson'`
5. Evaluar con R^2, RMSE, MAE
6. Guardar el mejor modelo en `models/` con pickle

**Archivo a completar:** `src/model_training.py`
**Funciones necesarias:**
- `train_model(X_train, y_train, criterion)` -> modelo entrenado
- `evaluate_model(model, X_test, y_test)` -> metricas
- `save_model(model, filepath)` -> guardar modelo

**Requisito:** R^2 > 0.80

---

### Companero B - SMART 5 (API REST)

**SMART 5 - Creacion de API Rest** (10 de agosto):

**Que hacer:**
1. Implementar FastAPI en `api/main.py`
2. Crear endpoint POST `/predict` que reciba attributes y retorne `predicted_price`
3. Crear endpoint GET `/model-info` con info del modelo
4. Usar `api/model.py` para cargar el modelo entrenado
5. Usar `api/schemas.py` para definir input/output con Pydantic
6. Probar con el frontend Flutter

**Endpoints necesarios:**
```python
POST /predict
{
  "GrLivArea": 150,
  "TotalBsmtSF": 80,
  "GarageCars": 2,
  "FullBath": 2,
  "YearBuilt": 2005
}
-> { "predicted_price": 250000.0 }

GET /model-info
-> { "model_type": "DecisionTree", "r2_score": 0.82, "features": [...] }
```

---

## Fechas Importantes

| SMART | Responsable | Fecha Limite |
|-------|-------------|--------------|
| SMART 1 | Mariana | 2da semana de julio |
| SMART 2 | Mariana | 3ra semana de julio |
| SMART 3 | Companero A | 4ta semana de julio |
| SMART 4 | Companero A/B | 1ra semana de agosto |
| SMART 5 | Companero B | 10 de agosto |

---

## Como Correr el Proyecto

### Backend (Python)
```bash
# Instalar dependencias
pip install -r requirements.txt

# Correr notebook SMART 1 y 2
cd notebooks
jupyter notebook 01_recopilacion_datos.ipynb
jupyter notebook 02_limpieza_datos.ipynb

# Correr API (cuando este lista)
cd api
uvicorn main:app --reload
```

### Frontend (Flutter)
```bash
cd flutter_app
flutter pub get
flutter run
```

---

## Dataset

**Ames Iowa Housing Dataset**
- Source: https://www.kaggle.com/c/house-prices-advanced-regression-techniques/data
- Registros: 1460
- Features: 79 (36 numericas, 43 categoricas)
- Target: `SalePrice`
- Guardar en: `data/raw/train.csv`
