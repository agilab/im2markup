#!/bin/bash
#Preprocess
root_path="$1"
img_path="$root_path/images"
img_precessed_path="$root_path/images_processed/"
#img_precessed_path="$img_path"

if [ $# -ne 1 ];then
    echo "Usgae: $0 <data rootpath>"
    exit -1
fi

if [ ! -d "$root_path" ];then
    echo "Usgae: $0 <data rootpath>"
    exit -1
fi

if [ ! -d "$img_path" ];then
    echo "Usgae: $0 <data rootpath>"
    echo "The image file must be stored in [$img_path]"
    exit -1
fi

# 1)图像裁剪.crop the formula area, and group images of similar sizes to facilitate batching,To accelerate training
mkdir -p "$img_precessed_path"

python scripts/preprocessing/preprocess_images.py --input-dir $img_path --output-dir $img_precessed_path
ori_path="$PWD"
cd "$img_precessed_path"
 ls >../test.lst
 cd ..
 num=`wc -l test.lst | awk '{print $1}'`
 let num=num-1
 seq 0 1 $num >idlist
 paste -d' ' test.lst idlist >test_idlist.lst
 mv idlist false_formulas.lst
cd "$ori_path"

list_path="$root_path/test_idlist.lst"
formulas_path="$root_path/false_formulas.lst"
out_path="$root_path/results"
echo "num of list:"`wc -l "$list_path"`
################################
mkdir -p "$out_path"
################################
th src/train.lua -phase test -gpu_id 1 -load_model -model_dir model/latex -visualize \
-data_base_dir $img_precessed_path \
-data_path $list_path \
-label_path $formulas_path \
-output_dir $out_path \
-max_num_tokens 500 -max_image_width 800 -max_image_height 800 \
-batch_size 5 -beam_size 5

