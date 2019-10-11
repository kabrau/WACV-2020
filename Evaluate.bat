set datasetFolder=F:/datasets/door_e_indoor/dataset
rem F:/datasets/door_stair
set projectFolder=E:/GitHub/WACV-2020

rem goto EvalFASTER
goto EvalSSD
rem goto EvalMobile
goto EvalYOLO

goto FIM

rem ======================================================================
:EvalFASTER

set configFile=faster_rcnn_inception_v2.config
set modelName=Faster_Inception
set numeroEpochModel=200000

goto EVAL


rem ======================================================================
:EvalSSD

set configFile=ssd_inception_v2_coco.config
set modelName=SSD_Inception
set numeroEpochModel=100000

goto EVAL

rem ======================================================================
:EvalMobile

set configFile=ssd_mobilenet_v2_coco.config
set modelName=SSD_mobilenet
set numeroEpochModel=100000

goto EVAL


rem ======================================================================
rem    YOLO
rem ======================================================================
:EvalYOLO

set modelName=YOLOv3
set dataset=test

cd E:\GitHub\keras-yolo3
python evaluate.py -c %projectFolder%\config\config_yolo.json -e %projectFolder%\config\config_yolo_test.json > %projectFolder%/results/%modelName%-%dataset%.txt
rem python yolo_evaluate_models.py -c %projectFolder%\config\config_yolo.json -i %datasetFolder%/%dataset%/ -o %datasetFolder%/result/%modelName%-%dataset%
rem cd E:\GitHub\PyImageRoi\source
rem python mAP.py -a=%datasetFolder%/%dataset%.ann -c opened_door closed_door elevator_door ascending_stair descending_stair -i 0.2 -s 0.0 -r=%datasetFolder%/result/%modelName%-%dataset% > %projectFolder%/results/%modelName%-%dataset%.txt

goto FIM

rem ======================================================================
:EVAL

cd E:\GitHub\tensorflow\models\research
python object_detection/export_inference_graph.py --input_type=image_tensor --pipeline_config_path=%projectFolder%/config/%configFile% --trained_checkpoint_prefix=%datasetFolder%/training/%modelName%/model.ckpt-%numeroEpochModel% --output_directory=%datasetFolder%/inference/%modelName%/

cd E:\GitHub\PyImageRoi\source

set dataset=test
python object_detection_evaluate_models.py -i=%datasetFolder%/%dataset%/ -l=%projectFolder%/config/label_map.pbtxt -f=%datasetFolder%/inference/%modelName%/frozen_inference_graph.pb -o=%datasetFolder%/result/%modelName%-%dataset%
python mAP.py -a=%datasetFolder%/%dataset%.ann -c opened_door closed_door elevator_door ascending_stair descending_stair -i 0.45 -s 0.0 -r=%datasetFolder%/result/%modelName%-%dataset% > %projectFolder%/results/%modelName%-%dataset%.txt

rem set dataset=valid
rem python object_detection_evaluate_models.py -i=%datasetFolder%/%dataset%/ -l=%projectFolder%/config/label_map.pbtxt -f=%datasetFolder%/inference/%modelName%/frozen_inference_graph.pb -o=%datasetFolder%/result/%modelName%-%dataset%
rem python mAP.py -a=%datasetFolder%/%dataset%.ann -c opened_door closed_door elevator_door ascending_stair descending_stair -i 0.5 -s 0.0 -r=%datasetFolder%/result/%modelName%-%dataset% > %projectFolder%/results/%modelName%-%dataset%.txt

rem set dataset=train
rem python object_detection_evaluate_models.py -i=%datasetFolder%/%dataset%/ -l=%projectFolder%/config/label_map.pbtxt -f=%datasetFolder%/inference/%modelName%/frozen_inference_graph.pb -o=%datasetFolder%/result/%modelName%-%dataset%
rem python mAP.py -a=%datasetFolder%/%dataset%.ann -c opened_door closed_door elevator_door ascending_stair descending_stair -i 0.5 -s 0.0 -r=%datasetFolder%/result/%modelName%-%dataset% > %projectFolder%/results/%modelName%-%dataset%.txt

goto FIM


rem ======================================================================
:FIM
cd %projectFolder%



