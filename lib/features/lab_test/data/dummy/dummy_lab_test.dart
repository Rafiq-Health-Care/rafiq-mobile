import 'package:rafiq/features/lab_test/data/models/lab_test_details_model.dart';

final labTest3 = {
  "name": "MITTAL",
  "testId": "42268",
  "fileId": "4814",
  "date": "2026-07-12T00:00:00.000Z",
  "tests": [
    {
      "testName": "HAEMOGLOBIN",
      "result": 12.0,
      "unit": "gm/dl",
      "status": "NORMAL",
    },
    {"testName": "TLC", "result": 19800.0, "unit": "icc.mm", "status": "HIGH"},
    {"testName": "NEUTROPHILS", "result": 78.0, "unit": "%", "status": "HIGH"},
    {"testName": "LYMPHOCYTES", "result": 17.0, "unit": "%", "status": "LOW"},
    {"testName": "MONOCYTE", "result": 3.0, "unit": "%", "status": "NORMAL"},
    {"testName": "EOSINOPHILS", "result": 2.0, "unit": "%", "status": "NORMAL"},
    {
      "testName": "BASHOPHILS",
      "result": 0.0,
      "unit": "Foumm",
      "status": "NORMAL",
    },
    {
      "testName": "RBC",
      "result": 3.90,
      "unit": "million/cumm",
      "status": "NORMAL",
    },
    {"testName": "PCV", "result": 36.2, "unit": "%", "status": "NORMAL"},
    {"testName": "MCV", "result": 81.2, "unit": "%", "status": "NORMAL"},
    {"testName": "MCH", "result": 26.5, "unit": "pg.", "status": "LOW"},
    {"testName": "MCHC", "result": 30.2, "unit": "gmdl/", "status": "NORMAL"},
    {
      "testName": "PLATELATE COUNT",
      "result": 2.08,
      "unit": "lac/cumm",
      "status": "LOW",
    },
    {"testName": "ROW", "result": 15.8, "unit": "%", "status": "NORMAL"},
    {"testName": "PCT", "result": 0.22, "unit": "%", "status": "NORMAL"},
    {"testName": "MPV", "result": 10.5, "unit": "%", "status": "HIGH"},
  ],
};

LabTestDetailsModel labTestDetailsModel = LabTestDetailsModel.fromJson(
  labTest3,
);
