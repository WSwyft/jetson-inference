# Microwave Safe Classifier 🔥

This project uses Jetson Nano/Orin and PyTorch to train and deploy a custom image classifier that determines whether an object is **Microwave Safe** or **Not Microwave Safe**.

---

## 📁 Project Structure

```bash
jetson-inference/
├── data/
│   └── testdataset/             # Custom dataset (train/valid/test folders)
├── inference_outputs/           # Classified test images
├── models/
│   └── testdataset/
│       └── resnet18.onnx        # Exported ONNX model
├── python/
│   └── training/
│       └── classification/
│           ├── train.py         # Training script
│           └── voc.py           # (optional) dataset util
├── batch_inference.sh           # Batch inference script
├── .gitignore
└── README.md

📦 Requirements
Jetson Nano / Orin

PyTorch & torchvision (preinstalled in Jetson containers)

jetson-inference (with submodules)

Your dataset in ImageNet folder format

cd /home/nvidia03/jetson-inference/python/training/classification

Training
python3 train.py \
  --model-dir=/home/nvidia03/jetson-inference/models/testdataset \
  /home/nvidia03/jetson-inference/data/testdataset \
  --arch=resnet18 \
  --epochs=25 \
  --batch-size=8

Export to ONNX
python3 onnx_export.py --model-dir=models/testdataset

Single Image Inference
python3 /home/nvidia03/jetson-inference/python/examples/imagenet.py \
  --model=models/testdataset/resnet18.onnx \
  --labels=data/testdataset/labels.txt \
  --input_blob=input_0 \
  --output_blob=output_0 \
  data/testdataset/test/Microwave\ Not\ Safe/example.jpg \
  output.jpg

 Batch Inference
chmod +x batch_inference.sh
./batch_inference.sh
This saves outputs to:
inference_outputs/

 To Do / Future Work
Improve model accuracy (data augmentation, deeper architectures)

Visual dashboard of results

Export results to CSV

Optimize ONNX model with TensorRT
