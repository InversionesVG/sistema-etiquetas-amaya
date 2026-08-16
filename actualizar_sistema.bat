@echo off
setlocal EnableDelayedExpansion
title Actualizar Sistema de Etiquetas Amaya

echo ==========================================================
echo   ACTUALIZAR SISTEMA DE ETIQUETAS AMAYA (Windows)
echo ==========================================================
echo.

REM ------------------------------------------------------------
REM Si algun dia mueves la carpeta del repo o el .exe de produccion,
REM solo cambia estas dos rutas y el resto del script sigue igual.
REM ------------------------------------------------------------
set REPO_DIR=C:\Sistema_Etiquetas\sistema-etiquetas-amaya
set EXE_DESTINO=C:\Sistema_Etiquetas\Generador_Etiquetas_Amaya.exe
set NOMBRE_EXE=Generador_Etiquetas_Amaya

cd /d "%REPO_DIR%"
if errorlevel 1 (
    echo [ERROR] No se encontro la carpeta del repositorio:
    echo     %REPO_DIR%
    echo Verifica la ruta al inicio de este .bat y vuelve a intentar.
    pause
    exit /b 1
)

echo [1/4] Descargando los ultimos cambios de GitHub...
echo.
git pull
if errorlevel 1 (
    echo.
    echo [ERROR] Fallo "git pull". Revisa tu conexion a internet,
    echo o si hay cambios locales en esta carpeta que esten bloqueando la actualizacion.
    pause
    exit /b 1
)
echo.

echo [2/4] Instalando/actualizando dependencias de Python...
echo.
pip install -r requirements.txt
if errorlevel 1 (
    echo.
    echo [ERROR] Fallo la instalacion de dependencias con pip.
    pause
    exit /b 1
)
echo.

echo [3/4] Generando el nuevo .exe (puede tardar 1-2 minutos, espera)...
echo.
pyinstaller --onefile --windowed --name="%NOMBRE_EXE%" generador_etiquetas_gui.py --clean
if errorlevel 1 (
    echo.
    echo [ERROR] Fallo la generacion del .exe con PyInstaller.
    pause
    exit /b 1
)
echo.

echo [4/4] Reemplazando el ejecutable de produccion...
echo.
if exist "%EXE_DESTINO%" (
    echo Cerrando el programa por si estaba abierto...
    taskkill /IM "%NOMBRE_EXE%.exe" /F >nul 2>&1
    timeout /t 2 /nobreak >nul
)

copy /Y "dist\%NOMBRE_EXE%.exe" "%EXE_DESTINO%"
if errorlevel 1 (
    echo.
    echo [ERROR] No se pudo copiar el nuevo .exe a:
    echo     %EXE_DESTINO%
    echo Es probable que el programa siga abierto. Cierralo manualmente
    echo y vuelve a correr este .bat.
    pause
    exit /b 1
)

echo.
echo ==========================================================
echo   LISTO. Sistema actualizado correctamente.
echo   Ejecutable nuevo en: %EXE_DESTINO%
echo ==========================================================
echo.
pause
