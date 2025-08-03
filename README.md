
# AutoPanner Script

`autopanner.sh` is a Bash script for batch auto-panning audio and video files in a directory.

## Features
- Supports audio (`wav`, `mp3`, `flac`, `ogg`, `m4a`, `aac`, `aiff`) and video (`mp4`, `mov`, `mkv`, `avi`) formats
- Applies stereo auto-panning to audio using FFmpeg
- For video, only the audio is processed; video stream is copied
- Outputs to an `output` subdirectory with `_panned` added to filenames

## Requirements
- [FFmpeg](https://ffmpeg.org/) (install via Homebrew: `brew install ffmpeg`)
- Bash shell (macOS/Linux)

## Quick Start
1. Clone (`git clone https://github.com/noamtamir/autopanner-script.git`) or copy `autopanner.sh` to your local machine
2. Make it executable:
   ```sh
   chmod +x autopanner.sh
   ```
3. (Optional) Add alias to `~/.zshrc` or `~/.bashrc`:
   ```sh
   alias autopanner='bash /path/to/autopanner.sh'
   ```
   and then restart your shell:
   ```sh
   source ~/.zshrc  # or source ~/.bashrc
   ```

## Usage
```sh
autopanner <input_directory> <panning_frequency_in_Hz>
```
Example:
```sh
autopanner ./my_audio_files 0.5
```

## Notes
- Overwrites files in the output directory
- Does not process subdirectories

## License
MIT
