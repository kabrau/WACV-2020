set datasetFolder=F:/datasets/door_stair
set projectFolder=E:/GitHub/WACV-2020


cd E:\GitHub\tensorflow\models\research

rem ============= SSD ====================
python object_detection/legacy/train.py --train_dir=%datasetFolder%/training/SSD_Inception/ --pipeline_config_path=%projectFolder%/config/ssd_inception_v2_coco.config

rem ============= FASTER ==================
python object_detection/legacy/train.py --train_dir=%datasetFolder%/training/Faster_Inception/ --pipeline_config_path=%projectFolder%/config/faster_rcnn_inception_v2.config

rem ============= Mobilenet ===============
python object_detection/legacy/train.py --train_dir=%datasetFolder%/training/SSD_mobilenet/ --pipeline_config_path=%projectFolder%/config/ssd_mobilenet_v2_coco.config

rem ============= YOLO ====================
cd E:\GitHub\keras-yolo3
python train.py -c %projectFolder%\config\config_yolo.json


cd %projectFolder%


