-- 外部ステージを作成する (https://docs.snowflake.com/ja/sql-reference/sql/create-stage)
CREATE OR REPLACE STAGE IF NOT EXISTS <external_stage_name>
  internalStageParams
  directoryTableParams
  FILE_FORMAT = ( { FORMAT_NAME = '<file_format_name>' | TYPE = { CSV | JSON | AVRO | ORC | PARQUET | XML | CUSTOM } [ formatTypeOptions ] } ) ]
  COMMENT = '<string_literal>';


-- 外部ステージのプロパティを変更する (https://docs.snowflake.com/ja/sql-reference/sql/alter-stage)


-- 外部ステージを削除する (https://docs.snowflake.com/ja/sql-reference/sql/drop-stage)