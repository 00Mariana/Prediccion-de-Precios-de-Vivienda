"""
Modulo de procesamiento de datos para prediccion de precios de vivienda.
Contiene funciones reutilizables para limpieza y preprocesamiento.
"""
import pandas as pd
import numpy as np


def load_data(filepath: str) -> pd.DataFrame:
    """Carga el dataset desde un archivo CSV."""
    return pd.read_csv(filepath)


def handle_missing_values(df: pd.DataFrame) -> pd.DataFrame:
    """
    Maneja valores faltantes del dataset.
    - Columnas con >50% nulos: elimina la columna
    - Numericas: imputa con mediana
    - Categoricas: imputa con 'None' o moda
    """
    df = df.copy()

    # Eliminar columnas con mas del 50% de nulos
    umbral = len(df) * 0.5
    columnas_eliminar = [col for col in df.columns if df[col].isnull().sum() > umbral]
    df = df.drop(columns=columnas_eliminar)

    # Separar numericas y categoricas
    numericas = df.select_dtypes(include=[np.number]).columns
    categoricas = df.select_dtypes(include=['object']).columns

    # Imputar numericas con mediana
    for col in numericas:
        if df[col].isnull().sum() > 0:
            df[col] = df[col].fillna(df[col].median())

    # Imputar categoricas con moda o 'None'
    for col in categoricas:
        if df[col].isnull().sum() > 0:
            if df[col].mode().empty:
                df[col] = df[col].fillna('None')
            else:
                df[col] = df[col].fillna(df[col].mode()[0])

    return df


def encode_categoricals(df: pd.DataFrame) -> pd.DataFrame:
    """
    Convierte variables categoricas a numericas usando one-hot encoding.
    """
    df = df.copy()

    # Separar columnas
    numericas = df.select_dtypes(include=[np.number]).columns.tolist()
    categoricas = df.select_dtypes(include=['object']).columns.tolist()

    # One-hot encoding para categoricas
    if categoricas:
        df_encoded = pd.get_dummies(df[categoricas], drop_first=True)
        df = pd.concat([df[numericas], df_encoded], axis=1)

    return df


def remove_outliers(df: pd.DataFrame, column: str = 'SalePrice',
                    iqr_multiplier: float = 1.5) -> pd.DataFrame:
    """
    Elimina valores atipicos usando el metodo IQR (Rango Intercuartilico).
    """
    df = df.copy()

    Q1 = df[column].quantile(0.25)
    Q3 = df[column].quantile(0.75)
    IQR = Q3 - Q1

    limite_inferior = Q1 - iqr_multiplier * IQR
    limite_superior = Q3 + iqr_multiplier * IQR

    df = df[(df[column] >= limite_inferior) & (df[column] <= limite_superior)]

    return df


def select_features(df: pd.DataFrame, target: str = 'SalePrice',
                    threshold: float = 0.05) -> pd.DataFrame:
    """
    Selecciona caracteristicas basandose en correlacion con el target.
    Elimina columnas con correlacion absoluta menor al threshold.
    """
    df = df.copy()

    # Calcular correlaciones absolutas con el target
    correlaciones = df.corr(numeric_only=True)[target].abs()

    # Filtrar columnas con correlacion suficiente
    columnas_validas = correlaciones[correlaciones >= threshold].index.tolist()

    # Asegurar que el target este incluido
    if target not in columnas_validas:
        columnas_validas.append(target)

    return df[columnas_validas]


def preprocess_pipeline(filepath: str, output_path: str = None) -> pd.DataFrame:
    """
    Pipeline completo de preprocesamiento.
    Carga, limpia, codifica y guarda el dataset.
    """
    # Cargar
    df = load_data(filepath)

    # Limpiar nulos
    df = handle_missing_values(df)

    # Codificar categoricas
    df = encode_categoricals(df)

    # Eliminar outliers
    df = remove_outliers(df, column='SalePrice')

    # Seleccionar features
    df = select_features(df, target='SalePrice')

    # Guardar si se especifica ruta
    if output_path:
        df.to_csv(output_path, index=False)

    return df
