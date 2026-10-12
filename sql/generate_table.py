import pandas as pd
from pathlib import Path

# Find the project root automatically
project_root = Path(__file__).resolve().parent.parent

# File locations
csv_path = project_root / "data" / "processed" / "casualties_clean.csv"
output_path = project_root / "sql" / "create_casualties_table.sql"

table_name = "casualties_clean"

print("Reading:", csv_path)

# Load cleaned collision data
df = pd.read_csv(csv_path)

# Convert pandas data types to MySQL types
def mysql_type(dtype):
    dtype = str(dtype)

    if dtype.startswith("int"):
        return "BIGINT"
    elif dtype.startswith("float"):
        return "DOUBLE"
    elif dtype.startswith("datetime"):
        return "DATETIME"
    else:
        return "TEXT"

# Generate MySQL column definitions
columns = []

for column, dtype in df.dtypes.items():
    columns.append(f"`{column}` {mysql_type(dtype)}")

# Generate CREATE TABLE SQL
sql = f"""USE uk_road_safety;

DROP TABLE IF EXISTS {table_name};

CREATE TABLE {table_name} (
""" + ",\n".join(columns) + "\n);\n"

# Save SQL file
output_path.write_text(sql, encoding="utf-8")

print("SUCCESS")
print("Rows:", len(df))
print("Columns:", len(columns))
print("Created:", output_path)