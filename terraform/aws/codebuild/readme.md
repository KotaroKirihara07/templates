#ビルドの実行
aws codebuild start-build --project-name <project-name>

#既存のプロジェクトの設定値を上書きしてビルド
aws codebuild start-build --cli-input-json file://start-build.json