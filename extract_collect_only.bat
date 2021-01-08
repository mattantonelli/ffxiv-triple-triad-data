@echo off
SET GAMEPATH="C:\Program Files (x86)\Steam\steamapps\common\FINAL FANTASY XIV Online"
SET REPOPATH="C:\Users\Matt\Documents\Code\xiv-data"
SET /p VERSION=<%GAMEPATH%\game\ffxivgame.ver

ECHO Setting SC definition to the latest game version...
COPY %GAMEPATH%\game\ffxivgame.ver Definitions\game.ver

ECHO [%TIME%] Extracting game data...
.\SaintCoinach.Cmd.exe %GAMEPATH% "allexd Achievement AchievementCategory AchievementKind Action Addon AozActionTransient BuddyEquip Companion CompanionMove CompanionTransient ContentFinderCondition Emote EmoteCategory Item MinionRace MinionSkillType Mount MountTransient Orchestrion OrchestrionCategory Quest Recipe TextCommand"
.\SaintCoinach.Cmd.exe %GAMEPATH% "rawexd Achievement AozAction Cabinet CabinetCategory CharaMakeCustomize ItemAction"

ECHO [%TIME%] Extracting images...
.\SaintCoinach.Cmd.exe %GAMEPATH% "ui 000000 069999"
for /d %%i in (%CD%\%VERSION%\ui\icon\*) do (cd "%%i" & rmdir /S /Q hq 2>NUL)

ECHO [%TIME%] Compressing images...
powershell Compress-Archive -Force %CD%\%VERSION%\ui %CD%\%VERSION%\ui.zip

ECHO [%TIME%] Copying game data to the local repository...
XCOPY /S /Y /Q %CD%\%VERSION%\exd-all %REPOPATH%\exd-all
XCOPY /S /Y /Q %CD%\%VERSION%\rawexd %REPOPATH%\rawexd
MOVE /Y %CD%\%VERSION%\ui.zip %REPOPATH%

ECHO [%TIME%] Extract complete.
pause