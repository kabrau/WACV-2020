

set videoDatasetFolder=F:\datasets\door_stair\TestingVideos

cd E:\GitHub\PyImageRoi\source

FOR /D %%F IN (%videoDatasetFolder%\*) DO (
    @echo off
    echo ===========================================================================================
    echo %%~nxF %%F
    echo ===========================================================================================

    @echo on
    python ExportPascal2csv.py -p %%F/Annotations -o %%F\list.csv
    @echo off

)



cd E:\GitHub\WACV-2020