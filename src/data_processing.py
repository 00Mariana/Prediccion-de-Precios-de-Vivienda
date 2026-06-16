import pandas as pd
import numpy as np
from sklearn.preprocessing import OneHotEncoder
import os


def load_data(path: str) -> pd.DataFrame:
    """Load a CSV file into a DataFrame."""
    return pd.read_csv(path)


def handle_nulls(df: pd.DataFrame, threshold: float = 0.4) -> pd.DataFrame:
    """
    Handle missing values.
    - Drop columns where null percentage exceeds threshold.
    - Fill numeric columns with median.
    - Fill categorical columns with mode.
    """
    df = df.copy()

    null_pct = df.isnull().mean()
    cols_to_drop = null_pct[null_pct > threshold].index.tolist()

    if cols_to_drop:
        print(f"Dropping {len(cols_to_drop)} columns with >{threshold*100}% nulls: {cols_to_drop}")
        df = df.drop(columns=cols_to_drop)

    numeric_cols = df.select_dtypes(include=[np.number]).columns
    for col in numeric_cols:
        if df[col].isnull().sum() > 0:
            median_val = df[col].median()
            df[col] = df[col].fillna(median_val)

    categorical_cols = df.select_dtypes(include=['object']).columns
    for col in categorical_cols:
        if df[col].isnull().sum() > 0:
            mode_val = df[col].mode()[0]
            df[col] = df[col].fillna(mode_val)

    remaining = df.isnull().sum().sum()
    print(f"Nulls remaining: {remaining}")
    return df


def encode_categoricals(df: pd.DataFrame) -> pd.DataFrame:
    """
    One-hot encode categorical variables using sklearn OneHotEncoder.
    Returns the encoded DataFrame and saves the encoder for API use.
    """
    df = df.copy()
    categorical_cols = df.select_dtypes(include=['object']).columns.tolist()

    if not categorical_cols:
        print("No categorical columns to encode.")
        return df

    encoder = OneHotEncoder(sparse_output=False, handle_unknown='ignore')
    encoded_data = encoder.fit_transform(df[categorical_cols])
    encoded_df = pd.DataFrame(
        encoded_data,
        columns=encoder.get_feature_names_out(categorical_cols),
        index=df.index
    )

    df = df.drop(columns=categorical_cols)
    df = pd.concat([df, encoded_df], axis=1)

    print(f"Encoded {len(categorical_cols)} categorical columns -> {encoded_df.shape[1]} new features")

    import joblib
    os.makedirs('../models', exist_ok=True)
    joblib.dump(encoder, '../models/encoder.joblib')
    print("Encoder saved to models/encoder.joblib")

    return df


def remove_outliers(df: pd.DataFrame, column: str = 'SalePrice', iqr_multiplier: float = 1.5) -> pd.DataFrame:
    """
    Remove outliers using the IQR method on a specified column.
    Removes rows outside [Q1 - multiplier*IQR, Q3 + multiplier*IQR].
    """
    df = df.copy()
    Q1 = df[column].quantile(0.25)
    Q3 = df[column].quantile(0.75)
    IQR = Q3 - Q1

    lower_bound = Q1 - iqr_multiplier * IQR
    upper_bound = Q3 + iqr_multiplier * IQR

    before = len(df)
    df = df[(df[column] >= lower_bound) & (df[column] <= upper_bound)]
    after = len(df)

    print(f"Outliers removed from '{column}': {before - after} rows ({before} -> {after})")
    return df


def preprocess_pipeline(raw_path: str, output_path: str = None) -> pd.DataFrame:
    """
    Full preprocessing pipeline:
    1. Load data
    2. Drop Id column
    3. Handle nulls
    4. Remove outliers from SalePrice
    5. Encode categoricals
    """
    print("=== Loading Data ===")
    df = load_data(raw_path)
    print(f"Shape: {df.shape}")

    if 'Id' in df.columns:
        df = df.drop(columns=['Id'])

    print("\n=== Handling Nulls ===")
    df = handle_nulls(df)

    print("\n=== Removing Outliers ===")
    df = remove_outliers(df, column='SalePrice')

    print("\n=== Encoding Categoricals ===")
    df = encode_categoricals(df)

    print(f"\n=== Final Shape: {df.shape} ===")

    if output_path:
        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        df.to_csv(output_path, index=False)
        print(f"Saved to {output_path}")

    return df
