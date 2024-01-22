import os

import labelme2coco
import json

ROOT = os.getcwd()

# Specify the paths to the LabelMe annotations and the output COCO JSON file
labelme_annotations_path = os.path.join(ROOT, "sdo_hmii_flat_orange")
output_coco_json_path = os.path.join(ROOT, "coco")

# Convert LabelMe annotations to COCO format
labelme2coco.convert(
    labelme_annotations_path,
    output_coco_json_path
)

# Optionally, you can load and pretty-print the generated COCO JSON
with open(output_coco_json_path, "r") as f:
    coco_data = json.load(f)