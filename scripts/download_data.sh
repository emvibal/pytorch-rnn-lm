#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data

mkdir -p $data

tools=$base/tools

# link default training data for easier access

mkdir -p $data/wikitext-2

for corpus in train valid test; do
    absolute_path=$(realpath $tools/pytorch-examples/word_language_model/data/wikitext-2/$corpus.txt)
    ln -snf $absolute_path $data/wikitext-2/$corpus.txt
done

# download a different interesting data set!
# new data set included in the forked repo

mkdir -p $data/harry_potter

mkdir -p $data/harry_potter/raw

#wget https://raw.githubusercontent.com/ryanmcdermott/trump-speeches/master/speeches.txt
#mv speeches.txt $data/trump/raw

cp $data/harry_potter_1-4.txt $data/harry_potter/raw

# preprocess slightly

cat $data/harry_potter/raw/harry_potter_1-4.txt | python $base/scripts/preprocess_raw.py > $data/harry_potter/raw/harry_potter.cleaned.txt

# tokenize, fix vocabulary upper bound

cat $data/harry_potter/raw/harry_potter.cleaned.txt | python $base/scripts/preprocess.py --vocab-size 5000 --tokenize --lang "en" > \
    $data/harry_potter/raw/harry_potter.preprocessed.txt

# split into train, valid and test

head -n 500 $data/harry_potter/raw/harry_potter.preprocessed.txt > $data/harry_potter/valid.txt
head -n 1000 $data/harry_potter/raw/harry_potter.preprocessed.txt | tail -n 500 > $data/harry_potter/test.txt
tail -n 3260 $data/harry_potter/raw/harry_potter.preprocessed.txt > $data/harry_potter/train.txt
