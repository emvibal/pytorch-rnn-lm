#! /bin/bash

scripts=`dirname "$0"`
base=$(realpath $scripts/..)

models=$base/models
data=$base/data
tools=$base/tools

mkdir -p $models

num_threads=4
device=""

SECONDS=0

(cd $tools/pytorch-examples/word_language_model &&
    CUDA_VISIBLE_DEVICES=0 OMP_NUM_THREADS=$num_threads python main.py --data $data/harry_potterb \
        --epochs 40 \
        --emsize 300 --nhid 300 --dropout 0.4 --tied \
        --save $models/model_hp_vocab10k_embed300_dropout.4_epoch40.pt \
        --cuda
)

echo "time taken:"
echo "$SECONDS seconds"
