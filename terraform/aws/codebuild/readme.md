#ビルドの実行  
<code>aws codebuild start-build --project-name <project-name></code>  

#既存のプロジェクトの設定値を上書きしてビルド  
<code>aws codebuild start-build --cli-input-json file://start-build.json</code>