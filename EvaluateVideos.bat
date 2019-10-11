@echo off

set datasetFolder=F:\datasets\door_stair
set videoDatasetFolder=F:\datasets\door_stair\TestingVideos
set projectFolder=E:/GitHub/WACV-2020

cd E:\GitHub\PyImageRoi\source

goto EvalSSD

rem ======================================================================
:EvalFASTER

set configFile=faster_rcnn_inception_v2.config
set modelName=Faster_Inception
set numeroEpochModel=200000

@echo off
FOR /D %%F IN (%videoDatasetFolder%\*) DO (
    @echo off
    echo ===========================================================================================
    echo %%~nxF %%F
    echo ===========================================================================================

    @echo on
    python object_detection_evaluate_models.py -i=%%F/images -l=%projectFolder%/config/label_map.pbtxt -f=%datasetFolder%/inference/%modelName%/frozen_inference_graph.pb -o=%datasetFolder%/result/%modelName%-%%~nxF
    @echo off

    echo.%%~nxF | findstr /C:"door" 1>nul
    if errorlevel 1 (
        echo Stairs
        @echo on
        python mAP.py -a=%%F/Annotations -c ascending_stair descending_stair -i 0.5 -s 0.0 -r=%datasetFolder%/result/%modelName%-%%~nxF > %projectFolder%/results/%modelName%-%%~nxF.txt
        @echo off
    ) ELSE (
        echo Doors
        @echo on
        python mAP.py -a=%%F/Annotations -c opened_door closed_door elevator_door -i 0.5 -s 0.0 -r=%datasetFolder%/result/%modelName%-%%~nxF > %projectFolder%/results/%modelName%-%%~nxF.txt
        @echo off
    )
)

rem ======================================================================
@echo SSD
:EvalSSD

set configFile=ssd_inception_v2_coco.config
set modelName=SSD_Inception
set numeroEpochModel=100000

@echo off
FOR /D %%F IN (%videoDatasetFolder%\*) DO (
    @echo off
    echo ===========================================================================================
    echo %%~nxF %%F
    echo ===========================================================================================

    @echo on
    echo ------------- object_detection_evaluate_models.py -------------------------
    echo -i=%%F/images -l=%projectFolder%/config/label_map.pbtxt -f=%datasetFolder%/inference/%modelName%/frozen_inference_graph.pb -o=%datasetFolder%/result/%modelName%-%%~nxF
    python object_detection_evaluate_models.py -i=%%F/images -l=%projectFolder%/config/label_map.pbtxt -f=%datasetFolder%/inference/%modelName%/frozen_inference_graph.pb -o=%datasetFolder%/result/%modelName%-%%~nxF
    echo passou
    @echo off

    echo.%%~nxF | findstr /C:"door" 1>nul
    if errorlevel 1 (
        echo ===========> Stairs mAP
        @echo on
        python mAP.py -a=%%F/Annotations -c ascending_stair descending_stair -i 0.5 -s 0.0 -r=%datasetFolder%/result/%modelName%-%%~nxF > %projectFolder%/results/%modelName%-%%~nxF.txt
        @echo off
    ) ELSE (
        echo ===========> Doors mAP
        @echo on
        python mAP.py -a=%%F/Annotations -c opened_door closed_door elevator_door -i 0.5 -s 0.0 -r=%datasetFolder%/result/%modelName%-%%~nxF > %projectFolder%/results/%modelName%-%%~nxF.txt
        @echo off
    )
)

rem ======================================================================
:EvalMobile
@echo Mobile

set configFile=ssd_mobilenet_v2_coco.config
set modelName=SSD_mobilenet
set numeroEpochModel=100000

@echo off
FOR /D %%F IN (%videoDatasetFolder%\*) DO (
    @echo off
    echo ===========================================================================================
    echo %%~nxF %%F
    echo ===========================================================================================

    @echo on
    python object_detection_evaluate_models.py -i=%%F/images -l=%projectFolder%/config/label_map.pbtxt -f=%datasetFolder%/inference/%modelName%/frozen_inference_graph.pb -o=%datasetFolder%/result/%modelName%-%%~nxF
    @echo off

    echo.%%~nxF | findstr /C:"door" 1>nul
    if errorlevel 1 (
        echo Stairs
        @echo on
        python mAP.py -a=%%F/Annotations -c ascending_stair descending_stair -i 0.5 -s 0.0 -r=%datasetFolder%/result/%modelName%-%%~nxF > %projectFolder%/results/%modelName%-%%~nxF.txt
        @echo off
    ) ELSE (
        echo Doors
        @echo on
        python mAP.py -a=%%F/Annotations -c opened_door closed_door elevator_door -i 0.5 -s 0.0 -r=%datasetFolder%/result/%modelName%-%%~nxF > %projectFolder%/results/%modelName%-%%~nxF.txt
        @echo off
    )
)

goto FIM

rem ======================================================================
rem    YOLO
rem ======================================================================
:EvalYOLO

set modelName=YOLOv3
set dataset=test

cd E:\GitHub\keras-yolo3
rem python evaluate.py -c %projectFolder%\config\config_yolo.json -e %projectFolder%\config\config_yolo_test.json > %projectFolder%/results/%modelName%-%dataset%.txt


goto FIM



rem ======================================================================
:FIM
cd %projectFolder%



