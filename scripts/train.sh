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
    CUDA_VISIBLE_DEVICES=0 OMP_NUM_THREADS=$num_threads python main.py --data $data/harry_potter \
        --epochs 50 \
        --emsize 400 --nhid 400 --dropout 0.6 --tied \
        --save $models/model_hp_vocab5k_embed400_dropout.6_epoch40.pt \
        --cuda
)

echo "time taken:"
echo "$SECONDS seconds"
