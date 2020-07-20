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
**Make your data generation pipeline reproducible**

Make sure any randomization in data generation can be made deterministic. By
- Seed random number generator (RNG)
- Use invariant hash key

Consideration for hashing - hashing will always include or exclude certain queries --> your training will see less diverse set of queries

One more note: Make your hashing unique to ensure your system doesn't collide with other systems

**Downsampling without upweight downsampled data class will alter model base rate, so it is no longer calibrated.**
  A more intuitive explanation: Take one sample instead of all ten from the majority class (label with more samples in it), and add more weight onto that ONE sample (e.g. original weight might be 1.0, becomes 10.0 after downsampled the data (reduction of data points taken)).
  
### Classifier works perfectly in training, evaluation and testing sets but failed in production might be due to reasons below:
- groupings of data (clusters of data are evenly distributed across training and testing set and become too similar for model to learn)
- time series data (provide "sneak" preview to model)
- data with burstiness (intermittently as opposed to continuous stream)
