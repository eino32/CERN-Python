@echo off

REM Set the full path to the Jupyter executable
set JUPYTER_EXECUTABLE="%USERPROFILE%\Anaconda3\python.exe %USERPROFILE%\Anaconda3\cwp.py %USERPROFILE%\Anaconda3 %USERPROFILE%\Anaconda3\python.exe %USERPROFILE%\Anaconda3\Scripts\jupyter-notebook-script.py ""

REM Set the directory where the Jupyter Notebook is located
set JUPYTER_NOTEBOOK_DIR="C:\Users\etiirine\cernbox\Documents\etiirinen\Python\4K desorption measurements\Example notebook for desorption measurements.ipynb"

REM Set the directory where the data files are located
set DATA_DIR="C:\Users\etiirine\cernbox\Documents\etiirinen\Python\4K desorption measurements\HiLumi sample\4K desorption yield with preinjection\dynamic vacuum\EGA fully in"

REM Activate the Python environment (if necessary)
REM For example, if you are using Anaconda, uncomment the following line:
call activate myenv

REM Run the Jupyter Notebook
jupyter nbconvert --to notebook --execute %JUPYTER_NOTEBOOK_DIR%\analyze_data.ipynb

REM Iterate through subdirectories in the data directory
for /r %DATA_DIR% %%D in (*) do (
    REM Check if the current directory contains the required data files
    if exist "%%~fD\MID.tsv" (
        REM Run the Jupyter Notebook on the current directory
        jupyter nbconvert --to notebook --execute %JUPYTER_NOTEBOOK_DIR%\analyze_data.ipynb --ExecutePreprocessor.timeout=-1 --ExecutePreprocessor.allow_errors=True --FilesWriter.build_directory="%%~fD"
    )
)

REM Deactivate the Python environment (if necessary)
REM For example, if you are using Anaconda, uncomment the following line:
call deactivate

REM Pause the batch file to keep the command window open
pause
