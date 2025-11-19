#ビルドの実行  
<code>aws codebuild start-build --project-name <project-name></code>  

#必要なパラメータの調査  
<code>aws codebuild start-build --generate-cli-skeleton</code>

#既存のプロジェクトの設定値を上書きしてビルド  
<code>aws codebuild start-build --cli-input-json file://startbuild_params.json</code>