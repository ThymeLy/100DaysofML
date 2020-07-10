## Data Dependencies
The behavior of an ML system is dependent on the behavior and qualities of its input features. As the input data for those features changes, so too will your model. 
In traditional software development, you focus more on code than on data. In machine learning development, although coding is still part of the job, your focus must widen to include data. For example, on traditional software development projects, it is a best practice to write unit tests to validate your code. On ML projects, you must also continuously test, verify, and monitor your input data.
### Reliability
Some questions to ask about the reliability of your input data:
	* 
Is the signal always going to be available or is it coming from an unreliable source? For example:
	* 
Is the signal coming from a server that crashes under heavy load?
	* 
Is the signal coming from humans that go on vacation every August?

### Versioning
Some questions to ask about versioning:
	* 
Does the system that computes this data ever change? If so:
	* 
How often?
	* 
How will you know when that system changes?


Sometimes, data comes from an upstream process. If that process changes abruptly, your model can suffer.
Consider creating your own copy of the data you receive from the upstream process. Then, only advance to the next version of the upstream data when you are certain that it is safe to do so.

### Necessity
The following question might remind you of regularization:

Does the usefulness of the feature justify the cost of including it?
It is always tempting to add more features to the model. For example, suppose you find a new feature whose addition makes your model sli'ghtly more accurate. More accuracy certainly sounds better than less accuracy. However, now you've just added to your maintenance burden. That additional feature could degrade unexpectedly, so you've got to monitor it. Think carefully before adding features that lead to minor short-term wins.

### Correlations
Some features correlate (positively or negatively) with other features. Ask yourself the following question:
Are any features so tied together that you need additional strategies to tease them apart?

### Feedback Loops
Sometimes a model can affect its own training data. For example, the results from some models, in turn, are directly or indirectly input features to that same model.
Sometimes a model can affect another model. For example, consider two models for predicting stock prices:
Model A, which is a bad predictive model.
Model B.


Since Model A is buggy, it mistakenly decides to buy stock in Stock X. Those purchases drive up the price of Stock X. Model B uses the price of Stock X as an input feature, so Model B can easily come to some false conclusions about the value of Stock X stock. Model B could, therefore, buy or sell shares of Stock X based on the buggy behavior of Model A. Model B's behavior, in turn, can affect Model A, possibly triggering a tulip mania or a slide in Company X's stock
Which of the following models are susceptible to a feedback loop?

An election-results model that forecasts the winner of a mayoral race by surveying 2% of voters after the polls have closed.

If the model does not publish its forecast until after the polls have closed, it is not possible for its predictions to affect voter behavior.
Try again.

A face-attributes model that detects whether a person is smiling in a photo, which is regularly trained on a database of stock photography that is automatically updated monthly.

There is no feedback loop here, as model predictions don't have any impact on our photo database. However, versioning of our input data is a concern here, as these monthly updates could potentially have unforeseen effects on the model.


A university-ranking model that rates schools in part by their selectivity—the percentage of students who applied that were admitted.

The model's rankings may drive additional interest to top-rated schools, increasing the number of applications they receive. If these schools continue to admit the same number of students, selectivity will increase (the percentage of students admitted will go down). This will boost these schools' rankings, which will further increase prospective student interest, and so on…
3 of 3 correct answers.

A housing-value model that predicts house prices, using size (area in square meters), number of bedrooms, and geographic location as features.

It is not possible to quickly change a house's location, size, or number of bedrooms in response to price forecasts, making a feedback loop unlikely. However, there is potentially a correlation between size and number of bedrooms (larger homes are likely to have more rooms) that may need to be teased apart.


A book-recommendation model that suggests novels its users may like based on their popularity (i.e., the number of times the books have been purchased).

Book recommendations are likely to drive purchases, and these additional sales will be fed back into the model as input, making it more likely to recommend these same books in the future.
1 of 3 correct answers.

A traffic-forecasting model that predicts congestion at highway exits near the beach, using beach crowd size as one of its features.

Some beachgoers are likely to base their plans on the traffic forecast. If there is a large beach crowd and traffic is forecast to be heavy, many people may make alternative plans. This may depress beach turnout, resulting in a lighter traffic forecast, which then may increase attendance, and the cycle repeats.
2 of 3 correct answers.

## Fairness
Evaluating a machine learning model responsibly requires doing more than just calculating loss metrics. Before putting a model into production, it's critical to audit training data and evaluate predictions for bias.

#### Designing for Fairness
	1. Consider the problem
	2. Ask experts
	3. Train the models to account for bias
	4. Interpret outcomes
	5. Publish with context


### Fairness: Types of bias
##### Machine learning models are not inherently objective. Engineers train models by feeding them a data set of training examples, and human involvement in the provision and curation of this data can make a model's predictions susceptible to bias.
When building models, it's important to be aware of common human biases that can manifest in your data, so you can take proactive steps to mitigate their effects.
WARNING: The following inventory of biases provides just a small selection of biases that are often uncovered in machine learning data sets; this list is not intended to be exhaustive. Wikipedia's catalog of cognitive biases enumerates over 100 different types of human bias that can affect our judgment. When auditing your data, you should be on the lookout for any and all potential sources of bias that might skew your model's predictions.Reporting Bias
##### Reporting bias occurs when the frequency of events, properties, and/or outcomes captured in a data set does not accurately reflect their real-world frequency. This bias can arise because people tend to focus on documenting circumstances that are unusual or especially memorable, assuming that the ordinary can "go without saying."
EXAMPLE: A sentiment-analysis model is trained to predict whether book reviews are positive or negative based on a corpus of user submissions to a popular website. The majority of reviews in the training data set reflect extreme opinions (reviewers who either loved or hated a book), because people were less likely to submit a review of a book if they did not respond to it strongly. As a result, the model is less able to correctly predict sentiment of reviews that use more subtle language to describe a book.Automation Bias

##### Automation bias is a tendency to favor results generated by automated systems over those generated by non-automated systems, irrespective of the error rates of each.
EXAMPLE: Software engineers working for a sprocket manufacturer were eager to deploy the new "groundbreaking" model they trained to identify tooth defects, until the factory supervisor pointed out that the model's precision and recall rates were both 15% lower than those of human inspectors.Selection Bias
Selection bias occurs if a data set's examples are chosen in a way that is not reflective of their real-world distribution. Selection bias can take many different forms:
	* 
##### Coverage bias: Data is not selected in a representative fashion.
EXAMPLE: A model is trained to predict future sales of a new product based on phone surveys conducted with a sample of consumers who bought the product. Consumers who instead opted to buy a competing product were not surveyed, and as a result, this group of people was not represented in the training data.

##### Non-response bias (or participation bias): Data ends up being unrepresentative due to participation gaps in the data-collection process.


EXAMPLE: A model is trained to predict future sales of a new product based on phone surveys conducted with a sample of consumers who bought the product and with a sample of consumers who bought a competing product. Consumers who bought the competing product were 80% more likely to refuse to complete the survey, and their data was underrepresented in the sample.
	* 
##### Sampling bias: Proper randomization is not used during data collection.


EXAMPLE: A model is trained to predict future sales of a new product based on phone surveys conducted with a sample of consumers who bought the product and with a sample of consumers who bought a competing product. Instead of randomly targeting consumers, the surveyer chose the first 200 consumers that responded to an email, who might have been more enthusiastic about the product than average purchasers.Group Attribution Bias
##### Group attribution bias is a tendency to generalize what is true of individuals to an entire group to which they belong. Two key manifestations of this bias are:
	* 
In-group bias: A preference for members of a group to which you also belong, or for characteristics that you also share.


EXAMPLE: Two engineers training a résumé-screening model for software developers are predisposed to believe that applicants who attended the same computer-science academy as they both did are more qualified for the role.
	* 
##### Out-group homogeneity bias: A tendency to stereotype individual members of a group to which you do not belong, or to see their characteristics as more uniform.


EXAMPLE: Two engineers training a résumé-screening model for software developers are predisposed to believe that all applicants who did not attend a computer-science academy do not have sufficient expertise for the role.Implicit Bias
##### Implicit bias occurs when assumptions are made based on one's own mental models and personal experiences that do not necessarily apply more generally.
EXAMPLE: An engineer training a gesture-recognition model uses a head shake as a feature to indicate a person is communicating the word "no." However, in some regions of the world, a head shake actually signifies "yes."
A common form of implicit bias is confirmation bias, where model builders unconsciously process data in ways that affirm preexisting beliefs and hypotheses. In some cases, a model builder may actually keep training a model until it produces a result that aligns with their original hypothesis; this is called experimenter's bias.
EXAMPLE: An engineer is building a model that predicts aggressiveness in dogs based on a variety of features (height, weight, breed, environment). The engineer had an unpleasant encounter with a hyperactive toy poodle as a child, and ever since has associated the breed with aggression. When the trained model predicted most toy poodles to be relatively docile, the engineer retrained the model several more times until it produced a result showing smaller poodles to be more violent.

### Identifying bias
	1. missing feature values
	2. unexpected feature values
	3. data skew - under or over-represented - e.g. geographic bias

