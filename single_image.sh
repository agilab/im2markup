#!/bin/bash
#mkdir -p model/latex; 
#wget -P model/latex/ http://lstm.seas.harvard.edu/latex/model/latex/final-model
#**********
#------single image preprocess----------
if [ $# -ne 2 ];then
    echo "Usage: $0 <Input: image file> <Output: Text file>"
    exit -1
fi

SCRIPT_FILE=`readlink -f "$0"`
INPUT_IMG=`readlink -f "$1"`
OUTPUT_TXT=`readlink -f "$2"`
ORI_PATH="$PWD"
SCRIPT_DIR=`dirname "$SCRIPT_FILE"`
#------------------------------
TMP_CACHE_ROOT="./SINGLE_IMAGE_CACHE"
IMG_CACHE="$TMP_CACHE_ROOT/image"
RES_CACHE="$TMP_CACHE_ROOT/result"
TEST_FILTER="$TMP_CACHE_ROOT/test_filter.lst"
NORM_LIST="$TMP_CACHE_ROOT/formulas.norm.lst"

if [ ! -d "$IMG_CACHE" ];then
    mkdir -p "$IMG_CACHE"
fi

if [ ! -d "$RES_CACHE" ];then
    mkdir -p "$RES_CACHE"
fi

cp "$INPUT_IMG" "$IMG_CACHE/"
echo `basename "$INPUT_IMG"`" 0" > "$TEST_FILTER"
echo "1" > "$NORM_LIST"
>"$RES_CACHE/results.txt"
#----------------------------------

th src/train.lua -phase test -gpu_id 1 -load_model -model_dir model/latex -visualize \
-data_base_dir $IMG_CACHE \
-data_path $TEST_FILTER \
-label_path $NORM_LIST \
-output_dir $RES_CACHE \
-max_num_tokens 500 -max_image_width 800 -max_image_height 800 \
-batch_size 5 -beam_size 5

awk -F '\t' '{print $3}' "$RES_CACHE/results.txt" > "$OUTPUT_TXT"




