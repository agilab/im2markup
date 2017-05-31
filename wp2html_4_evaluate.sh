#!/bin/bash

python scripts/evaluation/evaluate_text_edit_distance.py --result-path results/results.txt
python scripts/evaluation/render_html.py --result-path results/results.txt --output-dir data/html_64_64_100k/images_rendered --no-replace
python scripts/evaluation/evaluate_image.py --images-dir data/html_64_64_100k/images_rendered/
