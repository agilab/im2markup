#!/bin/bash
# Text Metrics
python scripts/evaluation/evaluate_bleu.py --result-path results/results.txt --data-path data/sample/test_filter.lst --label-path data/sample/formulas.norm.lst
echo "**************************************************************"
python scripts/evaluation/evaluate_text_edit_distance.py --result-path results/results.txt
echo "**************************************************************"
echo "**************************************************************"
#Image Metrics
python scripts/evaluation/render_latex.py --result-path results/results.txt --data-path data/sample/test_filter.lst --label-path data/sample/formulas.lst --output-dir data/sample/images_rendered --no-replace
echo "**************************************************************"
python scripts/evaluation/evaluate_image.py --images-dir data/sample/images_rendered/
echo "**************************************************************"

