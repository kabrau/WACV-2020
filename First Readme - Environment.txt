==============================================================
1 - Frameworks

    to SSD, FASTER, MobileNet
        clone TensorFlow Models from https://github.com/tensorflow/models

    to YOLO
        clone Keras Yolo3 from https://github.com/experiencor/keras-yolo3 

==============================================================
2 - Download dataset
        load GetDataset.trained_checkpoint_prefix

==============================================================
3 - Download pretrained models 
        from https://drive.google.com/drive/folders/1J_p7FK7FFQeoYBZsViU3kBqOIu9b4cvA?usp=sharing
        or original tensorflow pretrained models 
            from https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/detection_model_zoo.md

==============================================================
4 - adjust folders 
        config files, change de folders name inside files
            config_yolo.json
            config_yolo_test.json
            faster_rcnn_inception_v2.config
            ssd_inception_v2_coco.config
            ssd_mobilenet_v2_coco.config 

        bath files, change de folders name inside files
            Train.bat
            Evaluate.bat

==============================================================
5 - adjust config files
    if the dataset was modified, need adjust the anchors in config_yolo.json
        cd E:\GitHub\keras-yolo3
        python gen_anchors.py -c E:/GitHub/WACV-2020\config\config_yolo.json

    if the dataset was modified, need adjust the anchors in config_yolo.json
        cd E:\GitHub\keras-yolo3
        python gen_anchors.py -c E:/GitHub/WACV-2020\config\config_yolo.json
