# Project: Can you recognize the emotion from an image of a face? 
<img src="figs/CE.jpg" alt="Compound Emotions" width="500"/>
(Image source: https://www.pnas.org/content/111/15/E1454)

### [Full Project Description](doc/project3_desc.md)

Term: Spring 2021

Team Members:
1. Chen, Pin-Chun 
2. Harris, Sean 
3. Xia, Zhihang 
4. Xiong, Yandong 
5. Yu, Shuqi 

+ Project summary: In this project, we created a classification engine for facial emotion recognition. We did the resampling of the data and applied both resampled and original data to the baseline model(gbm) and advanced model(Knn,PCA-LDA,Decision Tree, Random Forest, Neural Network). We see a remarkable increase in accuracy and AUC after we did the resample. Based on the training time, accuracy and AUC, we choose random forest as our advanced model.

	
**Contribution statement**: ([default](doc/a_note_on_contributions.md)) Pin-Chun did the resampling and the baseline model. Sean did the Neural Network model. Zhihang did the PCA-LDA model. Yandong did the desision tree and Knn model. Shuqi did the random forest model.

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
