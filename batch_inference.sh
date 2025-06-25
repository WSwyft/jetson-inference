#!/bin/bash

MODEL=/home/nvidia03/jetson-inference/models/testdataset/resnet18.onnx
LABELS=/home/nvidia03/jetson-inference/data/testdataset/labels.txt
INPUT_BLOB=input_0
OUTPUT_BLOB=output_0
OUTPUT_DIR=/home/nvidia03/jetson-inference/inference_outputs

mkdir -p "$OUTPUT_DIR"

# Path to the folder containing images to test
IMAGE_DIR=/home/nvidia03/jetson-inference/data/testdataset/test

# Loop over all images in subdirectories (recursively)
find "$IMAGE_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | while read -r img; do
    # Make a safe output file name by replacing slashes with underscores
    out_file="$OUTPUT_DIR/$(echo "$img" | sed 's|/|_|g')"
    
    echo "Processing $img ..."
    
    python3 /home/nvidia03/jetson-inference/python/examples/imagenet.py \
      --model="$MODEL" \
      --labels="$LABELS" \
      --input_blob="$INPUT_BLOB" \
      --output_blob="$OUTPUT_BLOB" \
      "$img" \
      "$out_file"
done
