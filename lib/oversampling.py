import os, sys, csv
import numpy as np
import smote_variants as sv

def Readdata(datapath):
	x = []
	r_n = 0
	f = open(datapath, 'r', encoding = 'big5')
	row = csv.reader(f, delimiter = ',')
	for r in row:
		if r_n != 0:
			x.append([])
			for i in range(1, len(r)):
				item = r[i]
				x[r_n - 1].append(int(item))
		else:
			title = r
		r_n = r_n + 1
	f.close
	x = np.array(x)
	return x, title

def ReaddataY(datapath):
	x = []
	r_n = 0
	f = open(datapath, 'r', encoding = 'big5')
	row = csv.reader(f, delimiter = ',')
	for r in row:
		if r_n != 0:
			for i in range(1, len(r)):
				item = r[i]
				x.append(int(item))
		r_n = r_n + 1
	f.close
	x = np.array(x)
	return x

def Genans(respath, data, title):
	y_test = []
	for i in range(len(data)):
		y_test.append([i])
		for j in range(len(data[i])):
			y_test[i].append(data[i][j])
	txt = open(respath, "w+")
	s = csv.writer(txt, delimiter=',', lineterminator='\n')
	s.writerow(title)
	for i in range(len(y_test)):
		s.writerow(y_test[i])
	txt.close()
	return

def Genans_Y(respath, data):
    y_test = []
    for i in range(len(data)):
        y_test.append([i])
        y_test[i].append(data[i])
    txt = open(respath, "w+")
    s = csv.writer(txt, delimiter=',', lineterminator='\n')
    s.writerow(["id","label"])
    for i in range(len(y_test)):
    	s.writerow(y_test[i])
    txt.close()
    return


if __name__ == '__main__':
	X, title = Readdata('../output/feature_train2_2.csv')
	y = ReaddataY('../output/label_train2_2.csv')

	oversampler= sv.distance_SMOTE()

	# X_samp and y_samp contain the oversampled dataset
	X_samp, y_samp= oversampler.sample(X, y)
	print(np.shape(X_samp))
	print(len(y_samp))
	Genans_Y('../output/label_train_oversam.csv', y_samp)
	Genans('../output/feature_train_oversam.csv', X_samp, title)





