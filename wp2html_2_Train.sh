#!/bin/bash
th src/train.lua -phase train -gpu_id 1 \
-input_feed -prealloc \
-data_base_dir data/html_64_64_100k/data/ \
-data_path data/html_64_64_100k/html_train.txt \
-vocab_file data/html_64_64_100k/html_vocab.txt \
-val_data_path data/html_64_64_100k/html_dev.txt \
-label_path data/html_64_64_100k/html_sources.txt \
-vocab_file data/html_64_64_100k/html_vocab.txt \
-max_num_tokens 100 -max_image_width 64 -max_image_height 64 \
-batch_size 100 -beam_size 1
