#!/bin/bash
#训练最重要的参数：
#data_base_dir，指定了图像的位置；
#data_path，训练文件；
#label_path，LaTeX公式；
#val_data_path，验证文件；
#vocab_file，每行一个标记(token)的字典文件

th src/train.lua -phase train -gpu_id 1 \
-model_dir model \
-input_feed -prealloc \
-data_base_dir data/sample/images_processed/ \
-data_path data/sample/train_filter.lst \
-val_data_path data/sample/validate_filter.lst \
-label_path data/sample/formulas.norm.lst \
-vocab_file data/sample/latex_vocab.txt \
-max_num_tokens 150 -max_image_width 500 -max_image_height 160 \
-batch_size 20 -beam_size 1

#在默认设置中，日志将输出到文件log.txt。
#日志记录了训练和验证的输出(perplexities)。
#model_dir指定了模型的保存位置。默认参数基于整个数据集优化。
#In order to overfit on this toy example，使用的参数learning_rate为0.05，-lr_decay为1.0，num_epochs为30，然后经过30轮后，
#the training perplexity can reach around 1.1 and the validation perplexity can only reach around 17.
