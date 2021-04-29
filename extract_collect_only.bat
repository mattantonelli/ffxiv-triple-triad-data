@echo off
SET GAMEPATH="C:\Program Files (x86)\Steam\steamapps\common\FINAL FANTASY XIV Online"
SET REPOPATH="C:\Users\Matt\Documents\Code\xiv-data"
SET /p VERSION=<%GAMEPATH%\game\ffxivgame.ver

ECHO Setting SC definition to the latest game version...
COPY %GAMEPATH%\game\ffxivgame.ver Definitions\game.ver

ECHO [%TIME%] Extracting game data...
.\SaintCoinach.Cmd.exe %GAMEPATH% "allexd Achievement AchievementCategory AchievementKind Action ActionTransient Addon AozActionTransient BuddyEquip Companion CompanionMove CompanionTransient ContentFinderCondition Emote EmoteCategory Item MinionRace MinionSkillType Mount MountTransient Orchestrion OrchestrionCategory Ornament Quest TextCommand Title"
.\SaintCoinach.Cmd.exe %GAMEPATH% "rawexd Achievement AozAction Cabinet CabinetCategory CharaMakeCustomize Emote ItemAction OrchestrionUiParam Recipe"

ECHO [%TIME%] Extracting images...
.\SaintCoinach.Cmd.exe %GAMEPATH% "ui 000000 069999"
.\SaintCoinach.Cmd.exe %GAMEPATH% "ui 072200 072459"
.\SaintCoinach.Cmd.exe %GAMEPATH% "uihd 131000 136999"
for /d %%i in (%CD%\%VERSION%\ui\icon\*) do (cd "%%i" & rmdir /S /Q hq 2>NUL)

ECHO [%TIME%] Compressing images...
"C:\Program Files\7-Zip\7z.exe" a %CD%\%VERSION%\ui.zip %CD%\%VERSION%\ui\*

ECHO [%TIME%] Copying game data to the local repository...
XCOPY /S /Y /Q %CD%\%VERSION%\exd-all %REPOPATH%\exd-all
XCOPY /S /Y /Q %CD%\%VERSION%\rawexd %REPOPATH%\rawexd
MOVE /Y %CD%\%VERSION%\ui.zip %REPOPATH%

ECHO [%TIME%] Extract complete.
pause