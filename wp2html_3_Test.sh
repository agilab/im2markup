#!/bin/bash
mkdir -p model/html; 
wget -P model/html/ http://lstm.seas.harvard.edu/latex/model/html/final-model

th src/train.lua -phase test -gpu_id 1 -load_model -model_dir model/html -visualize \
-data_base_dir data/html_64_64_100k/data/ \
-data_path data/html_64_64_100k/html_test.txt \
-label_path data/html_64_64_100k/html_sources.txt \
-output_dir results \
-max_num_tokens 400 -max_image_width 64 -max_image_height 64 \
-batch_size 80 -beam_size 5 
