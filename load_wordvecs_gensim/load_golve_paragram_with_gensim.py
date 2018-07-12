from gensim.scripts.glove2word2vec import glove2word2vec

from gensim.models.keyedvectors import KeyedVectors



​
inputName = "paragram_300_sl999.txt"
​#inputName = "glove.840B.300d.txt"



inputName = "paragram_300_sl999.txt"

outputName = "gensim_" + inputName
​
​
print('convert glove file to word2vec format')
glove2word2vec(glove_input_file = inputName, word2vec_output_file= outputName)
​
​
print('load the converted file (this will be very slow: ~20 min on my laptop)')
​
paragram_model = KeyedVectors.load_word2vec_format(outputName, binary=False, unicode_errors='ignore')
​
​
print('save the loaded file into binary format, such that the opening time will be much faster')
paragram_model.save_word2vec_format(outputName + ".bin", binary=True)
​
print('open the binary file.')
paragram_model2 = KeyedVectors.load_word2vec_format(outputName +".bin", binary=True)
​
