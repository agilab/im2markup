#!/bin/bash

fdlist="/home/xuxiduo/paper_ocr/lua_torch_im2latxt/im2markup-master/baidu_tiku_img/like_sx_a_img ./baidu_tiku_img/like_sx_q_img /home/xuxiduo/paper_ocr/lua_torch_im2latxt/im2markup-master/baidu_tiku_img/wenke_sx_a_img /home/xuxiduo/paper_ocr/lua_torch_im2latxt/im2markup-master/baidu_tiku_img/wenke_sx_q_img"
rm log.txt
for fd in $fdlist;
do    
    ./Test_New_data.sh "$fd" < input
    mv log.txt "$fd""_log.txt"
done
