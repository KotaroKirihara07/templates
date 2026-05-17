# https://learn.microsoft.com/ja-jp/azure/databricks/getting-started/ml-get-started

# Import required libraries
import numpy as np
import pandas as pd
import sklearn.datasets
import sklearn.metrics
import sklearn.model_selection
import sklearn.ensemble

import matplotlib.pyplot as plt

import optuna
import mlflow
from mlflow.optuna.storage import MlflowStorage
from mlflow.pyspark.optuna.study import MlflowSparkStudy

# 変数定義
CATALOG_NAME = "catalog_name"
SCHEMA_NAME = "schema_name"
TABLE_NAME = "table_name"
SHCEMA_PATH = f"{CATALOG_NAME}.{SCHEMA_NAME}"
TABLE_PATH = f"{CATALOG_NAME}.{SCHEMA_NAME}.{TABLE_NAME}"
RUN_NAME = "gradient_boost"

# MLflowクライアントを構成する
mlflow.set_registry_uri("databricks-uc")


def train(RUN_NAME, X_train, y_train, X_test, y_test):
    # Enable MLflow autologging for this notebook
    mlflow.autolog()

    with mlflow.start_run(run_name=RUN_NAME) as run:
        # ------ train model (start) -----
        model = sklearn.ensemble.GradientBoostingClassifier(random_state=0)

        # Models, parameters, and training metrics are tracked automatically
        model.fit(X_train, y_train)

        predicted_probs = model.predict_proba(X_test)
        roc_auc = sklearn.metrics.roc_auc_score(y_test, predicted_probs[:,1])
        roc_curve = sklearn.metrics.RocCurveDisplay.from_estimator(model, X_test, y_test)

        # Save the ROC curve plot to a file
        roc_curve.figure_.savefig("roc_curve.png")

        # ------ train model (end) -----

        # The AUC score on test data is not automatically logged, so log it manually
        mlflow.log_metric("test_auc", roc_auc)

        # Log the ROC curve image file as an artifact
        mlflow.log_artifact("roc_curve.png")


def predict(X_test):
    with mlflow.start_run(run_name=RUN_NAME) as run:
        model_loaded = mlflow.pyfunc.load_model('runs:/{run_id}/model'.format(run_id=run.info.run_id))
        predictions_loaded = model_loaded.predict(X_test)
    return predictions_loaded