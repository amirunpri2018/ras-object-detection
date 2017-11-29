#!/bin/bash
#
# Download the TF logs every once in a while to keep TensorBoard updated
# Then run: tensorboard  --logdir datasets/SmartHome/tflogs
#
. config.py

# Note both have trailing slashes
from="$remotessh:$remotedir"
to="$localdir"

# TensorFlow logs
while true; do
    # * Exclude the large model files
    # * --inplace so we don't get "file created after file even though it's
    #   lexicographically earlier" in TensorBoard, which basically makes it
    #   never update without restarting TensorBoard

    rsync -Pahuv --inplace --exclude="model.ckpt*" "$from/${datasetTFtrainlogs}_$TFArch/" "$to/${datasetTFtrainlogs}_$TFArch/"
    rsync -Pahuv --inplace --exclude="model.ckpt*" "$from/${datasetTFevallogs}_$TFArch/" "$to/${datasetTFevallogs}_$TFArch/"

    sleep 30
done
