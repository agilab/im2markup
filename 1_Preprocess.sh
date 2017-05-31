#!/bin/bash
#Preprocess

# 1)图像裁剪.crop the formula area, and group images of similar sizes to facilitate batching,To accelerate training
python scripts/preprocessing/preprocess_images.py --input-dir data/sample/images --output-dir data/sample/images_processed

#2)去掉空格,LaTeX formulas need to be tokenized or normalized.this command will produce some error messages since some formulas cannot be parsed by the KaTeX parser
python scripts/preprocessing/preprocess_formulas.py --mode normalize --input-file data/sample/formulas.lst --output-file data/sample/formulas.norm.lst

#3)准备训练，验证和测试文件。大图像将排除从训练和验证集中排除,并且略标记太多或有语法错误的公式。
python scripts/preprocessing/preprocess_filter.py --filter --image-dir data/sample/images_processed --label-path data/sample/formulas.norm.lst --data-path data/sample/train.lst --output-path data/sample/train_filter.lst 
python scripts/preprocessing/preprocess_filter.py --filter --image-dir data/sample/images_processed --label-path data/sample/formulas.norm.lst --data-path data/sample/validate.lst --output-path data/sample/validate_filter.lst 
python scripts/preprocessing/preprocess_filter.py --no-filter --image-dir data/sample/images_processed --label-path data/sample/formulas.norm.lst --data-path data/sample/test.lst --output-path data/sample/test_filter.lst 

#4)从训练集生成词汇。所有出现少于（包括）1次的标记将被排除在词汇表中。
python scripts/preprocessing/generate_latex_vocab.py --data-path data/sample/train_filter.lst --label-path data/sample/formulas.norm.lst --output-file data/sample/latex_vocab.txt


