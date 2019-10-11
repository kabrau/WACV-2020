set projectFolder=E:/GitHub/WACV-2020

rem cd E:\GitHub\PyImageRoi\source
rem python CreateBoundingBoxes.py -p C:/tempo/images/ -className opened_door closed_door elevator_door ascending_stair descending_stair

rem Needed make modifications in predict to create images with boxes
cd E:\GitHub\keras-yolo3

set modelName=YOLO
rem python predict.py -c E:/GitHub/WACV-2020\config\config_yolo.json -i C:/tempo/images/ -o C:/tempo/result-%modelName%/

cd E:\GitHub\PyImageRoi\source

set modelName=Faster_Inception
python object_detection_evaluate_models.py -i=C:/tempo/images/ -l=%projectFolder%/config/label_map.pbtxt -f=F:/datasets/door_e_indoor/dataset/inference/%modelName%/frozen_inference_graph.pb -o=C:/tempo/result-%modelName%

set modelName=SSD_Inception
python object_detection_evaluate_models.py -i=C:/tempo/images/ -l=%projectFolder%/config/label_map.pbtxt -f=F:/datasets/door_e_indoor/dataset/inference/%modelName%/frozen_inference_graph.pb -o=C:/tempo/result-%modelName%

set modelName=SSD_mobilenet
python object_detection_evaluate_models.py -i=C:/tempo/images/ -l=%projectFolder%/config/label_map.pbtxt -f=F:/datasets/door_e_indoor/dataset/inference/%modelName%/frozen_inference_graph.pb -o=C:/tempo/result-%modelName%

cd %projectFolder%