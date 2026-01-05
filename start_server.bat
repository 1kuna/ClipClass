@echo off
REM Qwen3-Omni Server Starter for RTX 4090 (Windows)
REM Run this script to start the vLLM server

set VENV_DIR=%USERPROFILE%\vllm-omni
set MODEL=cpatonn/Qwen3-Omni-30B-A3B-Instruct-AWQ-4bit
set PORT=8901

REM Create venv if it doesn't exist
if not exist "%VENV_DIR%\Scripts\activate.bat" (
    echo Creating virtual environment...
    python -m venv "%VENV_DIR%"
    call "%VENV_DIR%\Scripts\activate.bat"
    echo Installing vLLM (this may take a few minutes)...
    pip install -U vllm openai
) else (
    call "%VENV_DIR%\Scripts\activate.bat"
)

echo.
echo Starting Qwen3-Omni server on port %PORT%...
echo First run will download ~18GB model.
echo Press Ctrl+C to stop.
echo.

vllm serve %MODEL% ^
    --quantization awq ^
    --dtype bfloat16 ^
    --max-model-len 16384 ^
    --port %PORT% ^
    --host 0.0.0.0 ^
    --allowed-local-media-path / ^
    --gpu-memory-utilization 0.95

pause
