#!/bin/bash

echo "🎤 Setting up Local Voice Assistant with ChatterBox TTS"
echo "=================================================="

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed. Please install Python 3.8+ first."
    exit 1
fi

echo "✅ Python 3 found: $(python3 --version)"

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    echo "❌ pip3 is not installed. Please install pip first."
    exit 1
fi

echo "✅ pip3 found"

# Check if Ollama is installed
if ! command -v ollama &> /dev/null; then
    echo "⚠️  Ollama is not installed. Installing Ollama..."
    curl -fsSL https://ollama.ai/install.sh | sh
    echo "✅ Ollama installed"
else
    echo "✅ Ollama found: $(ollama --version)"
fi

# Install Python dependencies
echo "📦 Installing Python dependencies..."
pip3 install -r requirements.txt

# Install additional dependencies that might be needed
echo "🔧 Installing additional dependencies..."
pip3 install git+https://github.com/suno-ai/bark.git
pip3 install openai-whisper

# Check if Ollama is running
echo "🔍 Checking if Ollama is running..."
if curl -s http://localhost:11434/api/tags > /dev/null; then
    echo "✅ Ollama is running"
else
    echo "⚠️  Ollama is not running. Starting Ollama..."
    ollama serve &
    sleep 3
fi

# Check for models
echo "🤖 Checking for available models..."
MODELS=$(ollama list 2>/dev/null | grep -E "(gemma3|llama3|mistral)" || echo "")

if [ -z "$MODELS" ]; then
    echo "⚠️  No models found. Pulling recommended model (gemma3)..."
    ollama pull gemma3
else
    echo "✅ Models found:"
    echo "$MODELS"
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "To run the voice assistant:"
echo "1. Make sure Ollama is running: ollama serve"
echo "2. Run the app: python3 app.py"
echo ""
echo "Optional: Add a voice sample for cloning:"
echo "   python3 app.py --voice path/to/voice_sample.wav"
echo ""
echo "For help: python3 app.py --help" 