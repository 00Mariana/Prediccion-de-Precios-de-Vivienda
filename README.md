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

## Acceder a los Datos Limpios

El dataset limpio ya esta generado en `data/processed/train_clean.csv` (1,399 filas, 161 columnas).

### Opcion 1: Abrir en Excel (mas facil)

Desde la terminal (Command Prompt o PowerShell) en la carpeta del proyecto:

```
start data\processed\train_clean.csv
```

Esto abre el archivo directamente en Excel.

### Opcion 2: Jupyter Notebook (mejor para explorar)

Desde la terminal, navega a la carpeta notebooks y abre Jupyter:

```
cd notebooks
jupyter notebook
```

Se abre el navegador. Crea un notebook nuevo y ejecuta esta celda:

```python
import pandas as pd
pd.set_option('display.max_columns', None)
df = pd.read_csv('../data/processed/train_clean.csv')
df.head(10)
```

Esto muestra la tabla directamente en el notebook.

### Opcion 3: Desde Python rapido (en terminal)

```
python -c "import pandas as pd; pd.set_option('display.max_columns',None); print(pd.read_csv('data/processed/train_clean.csv').head(20))"
```

### Opcion 4: Carga rapida con Pickle

Ya existe un archivo pickle que carga ~10x mas rapido:

```python
df = pd.read_pickle('data/processed/train_clean.pkl')
```

### Funcion reutilizable

Copia esto en cualquier notebook o script:

```python
import pandas as pd

def cargar_datos_limpios():
    """Carga el dataset limpio."""
    return pd.read_csv('../data/processed/train_clean.csv')

df = cargar_datos_limpios()
```

### Notebook de exploracion

Abre `notebooks/05_datos_limpios.ipynb` para ver estadisticas, correlaciones y un resumen completo del dataset.
