#!/bin/bash
#mkdir -p model/latex; 
#wget -P model/latex/ http://lstm.seas.harvard.edu/latex/model/latex/final-model
#**********
th src/train.lua -phase test -gpu_id 1 -load_model -model_dir model/latex -visualize \
-data_base_dir data/sample/images_processed/ \
-data_path data/sample/test_filter.lst \
-label_path data/sample/formulas.norm.lst \
-output_dir results \
-max_num_tokens 500 -max_image_width 800 -max_image_height 800 \
-batch_size 5 -beam_size 5

#in order to output the predictions, a flag -visualize must be set.
#Note that we do not specify a vocabulary file here, 
#since it is already included in the model. After a while, 
#the perplexities will be logged, and the predictions file results.txt will be put to output_dir. 
#The format of the predicitons file is:
#
#<img_name1>\t<label_gold1>\t<label_pred1>\t<score_pred1>\t<score_gold1>
#<img_name2>\t<label_gold2>\t<label_pred>2\t<score_pred2>\t<score_gold2>
#where \t denotes tab.
