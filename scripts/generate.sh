#! /bin/bash

scripts=`dirname "$0"`
base=$(realpath $scripts/..)

models=$base/models
data=$base/data
tools=$base/tools
samples=$base/samples

mkdir -p $samples

num_threads=4
device=""

(cd $tools/pytorch-examples/word_language_model &&
    CUDA_VISIBLE_DEVICES=0 OMP_NUM_THREADS=$num_threads python generate.py \
        --data $data/harry_potterb \
        --words 500 \
        --checkpoint $models/model_hp_vocab10k_embed300_dropout.6_epoch40.pt \
        --outf $samples/sample_hpb_vocab10k_embed300_dropout.6_epoch40_temp.6 \
        --temperature .6 \
        --cuda
)
