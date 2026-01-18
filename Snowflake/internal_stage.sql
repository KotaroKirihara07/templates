-- 内部ステージを作成する (https://docs.snowflake.com/ja/sql-reference/sql/create-stage)
CREATE OR REPLACE STAGE IF NOT EXISTS <internal_stage_name>
  internalStageParams
  directoryTableParams
  FILE_FORMAT = ( { FORMAT_NAME = '<file_format_name>' | TYPE = { CSV | JSON | AVRO | ORC | PARQUET | XML | CUSTOM } [ formatTypeOptions ] } ) ]
  COMMENT = '<string_literal>';


-- 内部ステージのプロパティを変更する (https://docs.snowflake.com/ja/sql-reference/sql/alter-stage)


-- 内部ステージを削除する (https://docs.snowflake.com/ja/sql-reference/sql/drop-stage)