## 2 Sampling and spliting data
### Sampling
depends on the problem: what do we want to predict, and what features do we want
	* To use the feature previous query, you need to sample at the session level, because sessions contain a sequence of queries.
	* To use the feature user behavior from previous days, you need to sample at the user level.

### Imbalance data
skewed class proportion, e.g. low occurrence --> model don't have enough positive example to train on
Solution : Downsampling and upweighting

Downsampling - reduce number of majority class data in training set
upweighting - adding example weight on downsampled data [original weight * downsampling factor]

#### Why downsample & upweighting?
To make model improve on minority class
- faster convergence
- more disk space
- calibration (adjusted probabilities)

### Data split
Sometimes random split isn't the best approach.
When data shows
- groupings (clusters of data will be too similar in training and test set)
- time series data (provide "sneak preview" to model)
- data with burstiness (intermittent burst instead of continuous stream)

### Randomization
**Make your data generation pipeline reproducible"
