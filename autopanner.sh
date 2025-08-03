#!/bin/bash

# Auto-pan audio batch script for audio & video files
# Usage: ./auto_pan_batch.sh <input_directory> <panning_frequency_Hz>

if [ $# -ne 2 ]; then
  echo "Usage: $0 <input_directory> <panning_frequency_in_Hz>"
  exit 1
fi

INPUT_DIR="$1"
FREQ="$2"

INPUT_DIR="$(cd "$INPUT_DIR" && pwd)"
OUTPUT_DIR="$INPUT_DIR/output"

# Add video extensions here to process videos, audio extensions for audio files
EXTENSIONS=("wav" "mp3" "flac" "ogg" "m4a" "aac" "aiff" "mp4" "mov" "mkv" "avi")

mkdir -p "$OUTPUT_DIR"

shopt -s nullglob

for ext in "${EXTENSIONS[@]}"; do
  for file in "$INPUT_DIR"/*."$ext"; do
    base="$(basename "$file")"
    filename="${base%.*}"
    extension="${base##*.}"
    out="$OUTPUT_DIR/${filename}_panned.${extension}"

    echo "Processing '$file' → '$out' with pan frequency ${FREQ} Hz"

    # Check if file is video by extension
    if [[ "$extension" =~ ^(mp4|mov|mkv|avi)$ ]]; then
      # Video file: keep video stream, filter audio
      ffmpeg -y -i "$file" -filter_complex \
      "aeval=exprs='val(ch)*(0.5+0.5*sin(2*PI*t*$FREQ))|val(ch)*(0.5-0.5*sin(2*PI*t*$FREQ))',channelmap=channel_layout=stereo" \
      -c:v copy -c:a aac -b:a 192k "$out"
    else
      # Audio file: just filter audio
      ffmpeg -y -i "$file" -filter_complex \
      "aeval=exprs='val(ch)*(0.5+0.5*sin(2*PI*t*$FREQ))|val(ch)*(0.5-0.5*sin(2*PI*t*$FREQ))'" \
      "$out"
    fi

  done
done

shopt -u nullglob
