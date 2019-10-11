

set datasetFolder=F:\datasets\door_stair
set videoDatasetFolder=F:\datasets\door_stair\TestingVideos
set projectFolder=E:/GitHub/WACV-2020

cd E:\GitHub\PyImageRoi\source

rem goto EvalSSD

rem ======================================================================
:EvalFASTER

set configFile=faster_rcnn_inception_v2.config
set modelName=Faster_Inception
set numeroEpochModel=200000


FOR /D %%F IN (%videoDatasetFolder%\*) DO (
    
    echo ===========================================================================================
    echo %%~nxF %%F
    echo ===========================================================================================

    
    python object_detection_evaluate_models-WACV-2.py -i=%%F/images -l=%projectFolder%/config/label_map.pbtxt -f=%datasetFolder%/inference/%modelName%/frozen_inference_graph.pb -o=%datasetFolder%/resultVideos/%modelName%-%%~nxF
    

    echo.%%~nxF | findstr /C:"door" 1>nul
    if errorlevel 1 (
        echo Stairs
        
        python mAP.py -a=%%F/Annotations -c ascending_stair descending_stair -i 0.5 -s 0.0 -r=%datasetFolder%/resultVideos/%modelName%-%%~nxF > %projectFolder%/results/%modelName%-%%~nxF-Sem.txt
        python mAP.py -a=%%F/Annotations -c ascending_stair descending_stair -i 0.5 -s 0.0 -r=%datasetFolder%/resultVideos/%modelName%-%%~nxF/temporal > %projectFolder%/results/%modelName%-%%~nxF-Com.txt
        
    ) ELSE (
        echo Doors
        
        python mAP.py -a=%%F/Annotations -c opened_door closed_door elevator_door -i 0.5 -s 0.0 -r=%datasetFolder%/resultVideos/%modelName%-%%~nxF > %projectFolder%/results/%modelName%-%%~nxF-Sem.txt
        python mAP.py -a=%%F/Annotations -c opened_door closed_door elevator_door -i 0.5 -s 0.0 -r=%datasetFolder%/resultVideos/%modelName%-%%~nxF/temporal > %projectFolder%/results/%modelName%-%%~nxF-Com.txt
        
    )
)

rem ======================================================================
@echo SSD
:EvalSSD

set configFile=ssd_inception_v2_coco.config
set modelName=SSD_Inception
set numeroEpochModel=100000


FOR /D %%F IN (%videoDatasetFolder%\*) DO (
    
    echo ===========================================================================================
    echo %%~nxF %%F
    echo ===========================================================================================

    
    python object_detection_evaluate_models-WACV-2.py -i=%%F/images -l=%projectFolder%/config/label_map.pbtxt -f=%datasetFolder%/inference/%modelName%/frozen_inference_graph.pb -o=%datasetFolder%/resultVideos/%modelName%-%%~nxF
    

    echo.%%~nxF | findstr /C:"door" 1>nul
    if errorlevel 1 (
        echo Stairs
        
        python mAP.py -a=%%F/Annotations -c ascending_stair descending_stair -i 0.5 -s 0.0 -r=%datasetFolder%/resultVideos/%modelName%-%%~nxF > %projectFolder%/results/%modelName%-%%~nxF-Sem.txt
        python mAP.py -a=%%F/Annotations -c ascending_stair descending_stair -i 0.5 -s 0.0 -r=%datasetFolder%/resultVideos/%modelName%-%%~nxF/temporal > %projectFolder%/results/%modelName%-%%~nxF-Com.txt
        
    ) ELSE (
        echo Doors
        
        python mAP.py -a=%%F/Annotations -c opened_door closed_door elevator_door -i 0.5 -s 0.0 -r=%datasetFolder%/resultVideos/%modelName%-%%~nxF > %projectFolder%/results/%modelName%-%%~nxF-Sem.txt
        python mAP.py -a=%%F/Annotations -c opened_door closed_door elevator_door -i 0.5 -s 0.0 -r=%datasetFolder%/resultVideos/%modelName%-%%~nxF/temporal > %projectFolder%/results/%modelName%-%%~nxF-Com.txt
        
    )
)

rem goto FIM


rem ======================================================================
:EvalMobile
@echo Mobile

set configFile=ssd_mobilenet_v2_coco.config
set modelName=SSD_mobilenet
set numeroEpochModel=100000


FOR /D %%F IN (%videoDatasetFolder%\*) DO (
    
    echo ===========================================================================================
    echo %%~nxF %%F
    echo ===========================================================================================

    
    python object_detection_evaluate_models-WACV-2.py -i=%%F/images -l=%projectFolder%/config/label_map.pbtxt -f=%datasetFolder%/inference/%modelName%/frozen_inference_graph.pb -o=%datasetFolder%/resultVideos/%modelName%-%%~nxF
    

    echo.%%~nxF | findstr /C:"door" 1>nul
    if errorlevel 1 (
        echo Stairs
        
        python mAP.py -a=%%F/Annotations -c ascending_stair descending_stair -i 0.5 -s 0.0 -r=%datasetFolder%/resultVideos/%modelName%-%%~nxF > %projectFolder%/results/%modelName%-%%~nxF-Sem.txt
        python mAP.py -a=%%F/Annotations -c ascending_stair descending_stair -i 0.5 -s 0.0 -r=%datasetFolder%/resultVideos/%modelName%-%%~nxF/temporal > %projectFolder%/results/%modelName%-%%~nxF-Com.txt
        
    ) ELSE (
        echo Doors
        
        python mAP.py -a=%%F/Annotations -c opened_door closed_door elevator_door -i 0.5 -s 0.0 -r=%datasetFolder%/resultVideos/%modelName%-%%~nxF > %projectFolder%/results/%modelName%-%%~nxF-Sem.txt
        python mAP.py -a=%%F/Annotations -c opened_door closed_door elevator_door -i 0.5 -s 0.0 -r=%datasetFolder%/resultVideos/%modelName%-%%~nxF/temporal > %projectFolder%/results/%modelName%-%%~nxF-Com.txt
        
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



