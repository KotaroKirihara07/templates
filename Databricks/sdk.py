from databricks.sdk import WorkspaceClient

# 変数定義
CATALOG_NAME = "catalog_name"
SCHEMA_NAME = "schema_name"
TABLE_NAME = "table_name"
SHCEMA_PATH = f"{CATALOG_NAME}.{SCHEMA_NAME}"
TABLE_PATH = f"{CATALOG_NAME}.{SCHEMA_NAME}.{TABLE_NAME}"

# クライアントオブジェクトを作成する
w = WorkspaceClient()

# カタログを作成する
w.catalogs.create(name=CATALOG_NAME)

# スキーマを作成する
w.catalogs.create(name=SCHEMA_NAME, catalog_name=CATALOG_NAME)

# テーブルを作成する
