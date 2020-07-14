## Data Preparation and Feature Engineering in ML
from [Google](https://developers.google.com/machine-learning/data-prep/?utm_source=mlcc&utm_campaign=mlcc-next-steps&utm_medium=referral&utm_content=data-prep-ss)

### The quality and size of your data
Data trumps all. It's true that updating your learning algorithm or model architecture will let you learn different types of patterns, but if your data is bad, you will end up building functions that fit the wrong thing. The quality and size of the data set matters much more than which shiny algorithm you use.
"...most of the times when I tried to manually debug interesting-looking errors they could be traced back to issues with the training data." - Software Engineer, Google Translate
"Interesting-looking" errors are typically caused by the data. Faulty data may cause your model to learn the wrong patterns, regardless of what modeling techniques you try.

you'll spend the majority of time (~80%)  on a machine learning project constructing data sets and transforming data.

### Steps to Constructing Your Dataset
To construct your dataset (and before doing data transformation), you should:  
	1. Collect the raw data.  
	2. Identify feature and label sources.  
	3. Select a sampling strategy.  
	4. Split the data.  

**How many features should you pick ?**

Pick 1-3 features that seem to have strong predictive power.

  It’s best for your data collection pipeline to start with only one or two features. This will help you confirm that the ML model works as intended. Also, when you build a baseline from a couple of features, you'll feel like you're making progress!

  Start smaller. Every new feature adds a new dimension to your training data set. When the dimensionality increases, the volume of the space increases so fast that the available training data become sparse. The sparser your data, the harder it is for a model to learn the relationship between the features that actually matter and the label. This phenomenon is called "the curse of dimensionality."

“Garbage in, garbage out”
The preceding adage applies to machine learning. After all, your model is only as good as your data. 
As a rough rule of thumb, your model should train on at least an order of magnitude more examples than trainable parameters. Simple models on large data sets generally beat fancy models on small data sets. Google has had great success training simple linear regression models on large data sets.

### The Quality of a Data Set
It’s no use having a lot of data if it’s bad data; quality matters, too. But what counts as "quality"? It's a fuzzy term. Consider taking an empirical approach and picking the option that produces the best outcome. With that mindset, a quality data set is one that lets you succeed with the business problem you care about. In other words, the data is good if it accomplishes its intended task.
However, while collecting data, it's helpful to have a more concrete definition of quality. Certain aspects of quality tend to correspond to better-performing models:

- reliability - omitted values, duplicate examples, bad labels, bad feature values
- feature representation - normalization, outliers
- minimizing skew - training/serving skew
  that is, different results are computed for your metrics at training time vs. serving time. Causes of skew can be subtle but have deadly effects on your results. Always consider what data is available to your model at prediction time. During training, use only the features that you'll have available in serving, and make sure your training set is representative of your serving traffic.

The Golden Rule: Do unto training as you would do unto prediction. That is, the more closely your training task matches your prediction task, the better your ML system will perform

Relatedly, when you're training a model and get amazing evaluation metrics (like 0.99 AUC), look for these sorts of features that can bleed into your label.

### Joining Data Logs
When assembling a training set, you must sometimes join multiple sources of data.

**Types of Logs**
- transactional logs
- attribute data 
- aggregate statistics

Transactional logs record a specific event. For example, a transactional log might record an IP address making a query and the date and time at which the query was made. Transactional events correspond to a specific event.
Attribute data contains snapshots of information. For example:
- user demographics
- search history at time of query
 
Attribute data isn't specific to an event or a moment in time, but can still be useful for making predictions. 
  For prediction tasks not tied to a specific event (for example, predicting user churn, which involves a range of time rather than an individual moment), attribute data might be the only type of data.
Attribute data and transactional logs are related. For example, you can create a type of attribute data by aggregating several transactional logs, creating aggregate statistics. In this case, you can look at many transactional logs to create a single attribute for a user.

Aggregate statistics create an attribute from multiple transactional logs. For example: frequency of user queries, average click rate on a certain ad

#### Joining Log Sources
Each type of log tends to be in a different location. When collecting data for your machine learning model, you must join together different sources to create your data set. Some examples:

Leverage the user's ID and timestamp in transactional logs to look up user attributes at time of event.

It is critical to use event timestamps when looking up attribute data. If you grab the latest user attributes, your training data will contain the values at the time of data collection, which causes training/serving skew. If you forget to do this for search history, you could leak the true outcome into your training data!

### Identifying Labels and Sources
Direct vs. Derived Labels
- Direct label - "user is a Taylor Swift fan" 
- Derived label - "user has watched a Taylor Swift video on YouTube"

Your model will only be as good as the connection between your derived label and your desired prediction

Label Sources
- Direct label for Events, such as “Did the user click the top search result?”
- Direct label for Attributes, such as “Will the advertiser spend more than $X in the next week?”

Remember to consider seasonality or cyclical effects; for example, advertisers might spend more on weekends. For that reason, you may prefer to use a 14-day window instead, or to use the date as a feature so the model can learn yearly effects.
Choose event data carefully to avoid cyclical or seasonal effects or to take those effects into account.

If product doesn't exists yet -- don't have any data to log. In that case, you could take one or more of the following actions:
- Use a heuristic for a first launch, then train a system based on logged data.
- Use logs from a similar problem to bootstrap your system.
- Use human raters to generate data by completing tasks.
  Human raters can perform a wide range of tasks.
  The data forces you to have a clear problem definition.

Improving Quality
Always check the work of your human raters. For example, label 1000 examples yourself, and see how your results match the raters'. (Labeling data yourself is also a great exercise to get to know your data.) If discrepancies surface, don't assume your ratings are the correct ones, especially if a value judgment is involved. If human raters have introduced errors, consider adding instructions to help them and try again.
Looking at your data by hand is a good exercise regardless of how you obtained your data. 
