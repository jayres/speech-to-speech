# Speech to Text to LLM to Speech

Initially forked off of [https://github.com/vndee/local-talking-llm](https://github.com/vndee/local-talking-llm)

## Techstack
First, you should set up a Python environment. If you want to use a virtual env you have several options for this, including pyenv, virtualenv, poetry, and others that serve a similar purpose. 

 Here are several crucial libraries you'll need to install:

- **rich**: For a visually appealing console output.
- **openai-whisper**: A robust tool for speech-to-text conversion.
- **chatterbox-tts**: State-of-the-art text-to-speech synthesis with voice cloning and emotion control.
- **langchain**: A straightforward library for interfacing with Large Language Models (LLMs).
- **sounddevice**, **pyaudio**, and **speechrecognition**: Essential for audio recording and playback.

The most critical component here is the Large Language Model (LLM) backend, for which we will use **Ollama**. Ollama is widely recognized as a popular tool for running and serving LLMs offline. Basically, you just [need to download the Ollama application](https://ollama.com/), pull your preferred model, and run it.

### Installation

```bash
# Install dependencies
pip3 install -r requirements.txt

# Download NLTK data (for sentence tokenization)
python3.11 -c "import nltk; nltk.download('punkt')"
python3.11 -c "import nltk; nltk.download('punkt_tab')"

# Install and start Ollama
# Follow instructions at https://ollama.com
ollama pull llama3.1  # or any other model you prefer
```

### Usage

#### Basic Usage
```bash
# Must use Python above 3.11. Your commands will be different if you have a differnt Python setup
python3.11 app.py
```

#### With Voice Cloning
You can change the constant at the top of app.py with the voice sample you want. If you want to add a different voice sample you can place it in the `voices` folder.

Record a 10-30 second audio sample of the voice you want to clone, then:
```bash
python app.py --voice path/to/voice_sample.wav
```

#### With Custom Settings
```bash
# Adjust emotion and pacing
python app.py --exaggeration 0.7 --cfg-weight 0.3

# Use a different LLM model
python3.11 app.py --model codellama

# Save generated voice samples
python3.11 app.py --save-voice
```

### Configuration Options

- `--voice`: Path to audio file for voice cloning
- `--exaggeration`: Emotion intensity (0.0-1.0, default: 0.5)
  - Lower values (0.3-0.4): Calmer, more neutral delivery
  - Higher values (0.7-0.9): More expressive and emotional
- `--cfg-weight`: Controls pacing and delivery style (0.0-1.0, default: 0.5)
  - Lower values: Faster, more dynamic speech
  - Higher values: Slower, more deliberate speech
- `--model`: Ollama model to use (default: llama2)
- `--save-voice`: Save generated audio responses to `voices/` directory

### Troubleshooting

- **CUDA out of memory**: Use CPU mode or reduce model precision
- **Microphone not working**: Check system permissions and device settings
- **Slow inference**: Ensure you're using GPU if available, consider using smaller models
- **Voice cloning quality**: Use higher quality audio samples with clear speech

### Resources

- [ChatterBox GitHub](https://github.com/resemble-ai/chatterbox)
- [Ollama](https://ollama.ai)
- [Whisper](https://github.com/openai/whisper)
- [Original Blog Post](https://blog.duy-huynh.com/build-your-own-voice-assistant-and-run-it-locally/)

