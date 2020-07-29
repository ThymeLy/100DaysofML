[variance explained](http://varianceexplained.org/r/trump-tweets/)
[student project](https://www.msi.co.jp/tmstudio/stu17contents/No4_muc17_TMS.pdf)
[teaching notes](http://utstat.toronto.edu/~nathan/teaching/sta4002/Class4/trumptweets-students.html)
## geom_bar() vs geom_col() https://ggplot2.tidyverse.org/reference/geom_bar.html

library(dplyr)
library(purrr)
library(twitteR)


twitter_consumer_key <- '6GdTR9EYoAAG7vciCnUgcC4MX'
twitter_consumer_secret <- '28ijnGOvIWbJtN67lKYuwBCUfy1zj6mOx5cY7DyfLHRyQ4QH4c'
twitter_access_token <- "1014706107510501377-uJQ96SoRrmHr3mMeqq5AzMUs0ls6hN"
twitter_access_token_secret <- "Zgmoq0q2tidFx14kkkqQidfnqqxsx0nk9sEo7mdvpPMxl"
# You'd need to set global options with an authenticated app
# "Using browser based authentication"
setup_twitter_oauth(getOption("twitter_consumer_key"),
                    getOption("twitter_consumer_secret"),
                    getOption("twitter_access_token"),
                    getOption("twitter_access_token_secret"))
# "Using direct authentication"
setup_twitter_oauth(twitter_consumer_key, twitter_consumer_secret, twitter_access_token, twitter_access_token_secret)
# We can request only 3200 tweets at a time; it will return fewer
# depending on the API
trump_tweets <- userTimeline("realDonaldTrump", n = 3200)
trump_tweets_df <- tibble::as_tibble(map_df(trump_tweets, as.data.frame))

# if you want to follow along without setting up Twitter authentication,
# just use my dataset:
load(url("http://varianceexplained.org/files/trump_tweets_df.rda"))

library(tidyr)

tweets <- trump_tweets_df %>%
  select(id, statusSource, text, created) %>%
  extract(statusSource, "source", "Twitter for (.*?)<") %>%
  filter(source %in% c("iPhone", "Android"))

library(lubridate)
library(scales)
library(ggplot2)
library(stringr)

tweets %>%
  count(source, hour = hour(with_tz(created, "EST"))) %>%
  mutate(percent = n / sum(n)) %>%
  ggplot(aes(hour, percent, color = source)) +
  geom_line() +
  scale_y_continuous(labels = percent_format()) +
  labs(x = "Hour of day (EST)",
       y = "% of tweets",
       color = "")

tweet_quote <- tweets %>%
  count(source, quote = ifelse(str_detect(text, '^"'), "with quote", "without  quote")) 

ggplot(tweet_quote, aes(source, n, fill = quote)) + geom_bar(stat = 'identity', position = 'dodge')
# By default, geom_bar uses stat="bin". This makes the height of each bar equal to the number of cases in each group, and it is incompatible with mapping values to the y aesthetic. If you want the heights of the bars to represent values in the data, use stat="identity" and map a value to the y aesthetic.

tweet_picture_counts <- tweets %>%
  filter(!str_detect(text, '^"')) %>%
  count(source,
        picture = ifelse(str_detect(text, "t.co"),
                         "Picture/link", "No picture/link"))

ggplot(tweet_picture_counts, aes(source, n, fill = picture)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "", y = "Number of tweets", fill = "")

library(tidytext)

reg <- "([^A-Za-z\\d#@']|'(?![A-Za-z\\d#@]))"
tweet_words <- tweets %>%
  filter(!str_detect(text, '^"')) %>%
  mutate(text = str_replace_all(text, "https://t.co/[A-Za-z\\d]+|&amp;", "")) %>%
  unnest_tokens(word, text, token = "regex", pattern = reg) %>%
  filter(!word %in% stop_words$word,
         str_detect(word, "[a-z]"))

tweet_words %>% count(word) %>% top_n(30) %>% ggplot(aes(reorder(word, n), n)) + geom_col() + coord_flip()

tweet_words %>% count(word) %>% arrange(desc(n)) %>% top_n(30) %>% ggplot(aes(reorder(word, n), n)) + geom_col() + coord_flip()

android_iphone_ratios <- tweet_words %>%
  count(word, source) %>%
  filter(sum(n) >= 5) %>%
  spread(source, n, fill = 0) %>%
  ungroup() %>%
  mutate_each(funs((. + 1) / sum(. + 1)), -word) %>%
  mutate(logratio = log2(Android / iPhone)) %>%
  arrange(desc(logratio))

android_iphone_ratios %>% top_n(30) %>% ggplot(aes(word, logratio)) + geom_col() + coord_flip()
