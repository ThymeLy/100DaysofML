## 2 Sampling and spliting data
### Sampling
depends on the problem: what do we want to predict, and what features do we want
	* To use the feature previous query, you need to sample at the session level, because sessions contain a sequence of queries.
	* To use the feature user behavior from previous days, you need to sample at the user level.

### Imbalance data
skewed class proportion, e.g. low occurrence --> model don't have enough positive example to train on
Solution : Downsampling and upweighting
