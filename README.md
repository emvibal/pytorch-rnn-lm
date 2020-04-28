# Pytorch RNN Language Models

This repo shows how to train neural language models using [Pytorch example code](https://github.com/pytorch/examples/tree/master/word_language_model). 

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps

Clone this repository in the desired place:

    git clone https://github.com/bricksdont/pytorch-rnn-lm
    cd pytorch-rnn-lm

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software:

    ./scripts/install_packages.sh

# The steps from here on deviate slightly from the original steps from which this repository was forked

Download and preprocess data:

    ./scripts/download_data.sh

- I have experimented on two datasets: 
	1) Sherlock Novels
		http://www.gutenberg.org/ebooks/2852, accessed 15 April 2020
		http://www.gutenberg.org/ebooks/244, accessed 15 April 2020
		http://www.gutenberg.org/ebooks/2097, accessed 15 April 2020
		http://www.gutenberg.org/ebooks/3289, accessed 15 April 2020
	2) Harry Potter Novels (Books 1-4)
		https://www.kaggle.com/alex44jzy/harrypotter/data, accessed 27 April 2020

Both datasets have already been included in this repository as text files in the data folder (./data).

Below are the changed I made to the download_data.sh script:
1) create harry_potter folder in ./data
2) create a raw folder inside ./data/harry_potter
3) copied the Harry Potter data set from ./data to ./data harry_potter/raw
4) preprocess, tokenize and divide into training, validation and tests sets by changing the file path of the input and name and path of the ouput.

*The Sherlock novels dataset can also be used by following the steps above and just replacing all Harry Potter entries into Sherlock.
*I also payed around with the vocabulary and thus made another version of both sets with a vocabulary size of 10 000.

Train a model:

    ./scripts/train.sh

Since I conducted my experiments with a GPU, I had to modify some of the settings on the train.sh script:
	CUDA_VISIBLE_DEVICES=0 (changed)
    	--cuda (added)

Make sure to specify/change the data path/folder to the one you want to work on

I played around with different hyperparameters by changing the values for --epochs, --emsize and --nhid, and --droput.

The naming convention for the model has also been modified by including information on dataset, vocabulary size, embedding, dropout and epochs. This makes it easier to identfify later one which model was made following which hyperparameter/s.

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Generate (sample) some text from a trained model with:

    ./scripts/generate.sh

I also had to do the following modifications on generate.sh:
	CUDA_VISIBLE_DEVICES=0 (changed)
    	--cuda (added)

Make sure to set/change the path/folder name of your data source

Put in your selected language model and its path in checkpoint

I changes the number of words to be generated fromm 100 to 500

Assign an easy to understand filename for your sample output file. I opted to follow the naming convention I made in order to know which sample was generated from which model

I also tinkered with the temperature hyperparameter

-------------------------------------------------------------

If the scripts are run without changing anything it will create a model from a vocabulary size of 5000 with an embedding of 400, dropout .6, epochs =40

The temperature is set to .7 on the generate.sh script
_______________________________________________________________________________________________________________________________

I have done quite a lot of experiments and will only show 15 of them below using the Harry Potter data set. A pdf with all of the results I got is also included in this repository.


Harry Potter Dataset

Vocabulary size: 5000

Embedding	Dropout		Epoch		Perplexity
200		.5		40		101.64
300		.5		40		101.53
400		.5		40		104.49
400		.6		40		100.71
400		.65		40		101.76
100		.3		40		104.93
300		.6		40		101.08
1000		.65		40		104.65
300		.6		60		101.08


Vocabulary size: 10000

Embedding	Dropout		Epoch		Perplexity
200		.5		40		134.60
200		.3		40		140.54
300		.5		40		134.55
200		.5		30		134.60
200		.5		50		134.60









