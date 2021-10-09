@echo off
Color 1F
If not "%~1"=="" (goto ConvertFile720)

:Start
cls
echo Welcome to Alemismun's 360 YDL CLI, be sure this program is on the same folder as your ffmpeg and youtube-dl binaries.
echo This CLI can only download 360 videos, 180 videos are believed to be impossible.
echo.
echo Tell your favourite content creators to use better platforms! Such as iwara for MMD VR dance videos.
echo.
echo.
echo [CLI Protip: Right click on this window to paste a link]
set /P videolink="Enter video link... (eg https://www.youtube.com/watch?v=8DqSh_T20WY)"

:VideoSelect
cls
youtube-dl -F %videolink% --user-agent ''
echo.
echo Automatically select best settings?
set /P usebestsetting="Y/N"
if /I "%usebestsetting%" EQU "Y" goto :AutoBest
if /I "%usebestsetting%" EQU "N" goto :ManualQualitySelect
echo.
echo ERROR: INVALID ANSWER.
pause
goto VideoSelect

:ManualQualitySelect
set /P audiosetting="Enter audio quality setting..."
set /P videosetting="Enter video quality setting..."
cls
youtube-dl -f %videosetting%+%audiosetting% --merge-output-format mkv %videolink% --user-agent ''
pause
goto Start

:AutoBest
youtube-dl -f bestvideo+bestaudio --merge-output-format mkv %videolink% --user-agent ''
pause
goto Start

:ConvertFile720
cls
echo Converting file: %~1...
echo.
ffmpeg -i %~1 -vf scale=-1:720 -c:v libx264 -crf 0 -preset ultrafast -c:a copy %~n1_AL360CLICompress.mkv
echo.
echo Conversion process finished.
pause
exit