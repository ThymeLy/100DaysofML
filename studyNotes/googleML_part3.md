## ML Systems in the real world - Google's Machine Learning Crash Course Part III
### Cancer prediction
- model learn from hospital name (one of the feature included in patient data) instead of the image itself - subtle form of cheating that showed doctor diagnosis (e.g. Cancer Center name is a strong indicator of cancer) ---> **label leakage**

### Real World Example: 18th Century Literature
- extremely high accuracy in test dataset - suspicious - When examples from different authors are split equally among training, validation and test dataset, the model learn nuances in the usage of language (instead of the intended learning based on metaphor only) that affects the outcome
- **The moral**: carefully consider how you split examples.
- **Know what the data represents.**


### Some Effective ML guidelines:
- Keep your first model simple.
- Focus on ensuring data pipeline correctness.
- Use a simple, observable metric for training & evaluation.
- Own and monitor your input features. 
- Treat your model configuration as code: review it, check it in. 
- Write down the results of all experiments, especially "failures."

[Google's Machine Learning Crash Course](https://developers.google.com/machine-learning)
