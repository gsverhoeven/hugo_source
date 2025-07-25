# Choose background image

TODO: create category R for r-bloggers (for now we have category Statistics for the R-bloggers RSS feed)
AND category Python for Python-bloggers

# choose categories (more like a blog post taxonomy, high level)

# Blood Bowl
# Linux
# Data paper
# Data science
# Measurement
# Statistics
# Scientific writing
# Machine learning
# Deep learning

# choose tags (more like search keywords)

# Tags
# Pandas
# Python
# OpenJDK
# Ubuntu
# Beautiful Soup
# bayesian statistics
# causal graph
# COVID-19
# DAG
# Better bibtex
# Rmarkdown
# Zotero
# AI
# OpenAI Gym
# Reinforcement learning
# brms
# causal inference
# rstan
# Stan
# deep learning
# keras
# neural networks
# tensorflow
# copula
# fake data
# R
# simulation
# tetrachoric correlation
# process mining
# caret
# Arduino
# BART
# grf
# interaction detection
# random forest
# ranger

# Move from Jupyter notebook to Rmarkdown blogpost
# do next python post in Quarto

# do run all on python notebook in VS Code
# source venv in terminal with nbconvert installed
# jupyter nbconvert --to markdown nufflytics_blog_post.ipynb
# copy md to Rmd , adjust YAML

# move png to static/post/*files

# Toevoegen: 
# en uitzoeken hoe ik losse pngs automatisch in post/*-files/x.png krijg
# dit geldt alleen voor figuren die niet door Rmarkdown chunks worden gemaakt

# blogdown::install_hugo(version=0.63)
options(blogdown.hugo.version = "0.63.0")

# do blogdown:::build_rmds: only for new blog post

# empty the public folder

# this compiles all Rmds  and fills ./public in hugo_source


#blogdown:::build_rmds("content/post/2020-12-30-jacks_car_rental_gym.Rmd")
#blogdown:::build_rmds("content/post/2021_03_07_qlearning_frozenlake_convergence.Rmd")
#blogdown:::build_rmds("content/post/2021-05-02-workflow_scientific_papers.Rmd")
#blogdown:::build_rmds("content/post/2021_05_14_covid_rapid_test_reliability.Rmd")
#blogdown:::build_rmds("content/post/2021_12_30_fumbbl_dataset.Rmd")
#blogdown:::build_rmds("content/post/2022-01-04_java_webstart_forensics_ubuntu.Rmd")
#blogdown:::build_rmds("content/post/2022-03-20_nufflytics_blog_post.Rmd")
#blogdown:::build_rmds("content/post/2022-07-09-random_forest_rfe_vs_tuning.Rmd")
#blogdown:::build_rmds("content/post/2022-11-01_clustered_heatmaps_blood_bowl.Rmd")
#blogdown:::build_rmds("content/post/2023-03-01_fumbbl_rosters_blood_bowl.Rmd")
#blogdown:::build_rmds("content/post/2023-09-21_fumbbl_super_league.Rmd")
#blogdown:::build_rmds("content/post/2024-01-15-stan_in_azure_vm.Rmd")
#blogdown:::build_rmds("content/post/2024-08-01_fumbbl_replays_blog_post.Rmd")
#blogdown:::build_rmds("content/post/2025-04-29_fumbbl_league_team_development.Rmd")
# rebuild site

#The function blogdown::build_site() has an argument local that defaults to FALSE, which means building the website for publishing instead of local previewing
# The mode local = TRUE is primarily for blogdown::serve_site() to serve the website locally. 
#Draft and future posts are always rendered when local = TRUE, but not when local = FALSE. 
# This is for you to preview draft and future posts locally. 
# If you know the Hugo command line, it means the hugo command is called with the flags -D -F, or equivalently, --buildDrafts --buildFuture.

# https://bookdown.org/yihui/blogdown/local-preview.html
#If you have time-consuming code chunks in any Rmd files, you have to use either of these methods to save time:
# Do not call build_site(), but blogdown::hugo_build() instead. 
# The latter does not compile any Rmd files, but simply runs the hugo command to build the site. 
# Please use this method only if you are sure that your Rmd files do not need to be recompiled.

#deleten public folder voordat we hugo_build doen
unlink("public/*", recursive = TRUE)


blogdown::hugo_build()
print("site build")

# Do a local preview of the site

# knit opnieuw na elke save
options(blogdown.knit.on_save = FALSE) # voorkom dat alle RMds gemonitord worden, waardoor drafts Rmd ook gebouwd worden

#options(blogdown.skip.draft = TRUE) # werkt niet

#you should know that in the YAML front matter of your new file, you can add draft: TRUE and 
#you will be able to preview your post using blogdown::serve_site(), but conveniently your post will not show up on your deployed site until you set it to false.
blogdown::serve_site()

# http://localhost:4321

# after changes press shift-and click refresh to circumvent the caching mechanism

blogdown::stop_server()


# rebuild site after preview

#If your website does not work without the full baseurl, or you do not want the draft or future posts to be published, 
#you should not publish the public/ directory generated by serve_site(). 

# If your drafts and future posts contain (time-)sensitive information, you are strongly recommended to 
# delete the /public/ directory before you rebuild the site for publishing every time, because Hugo never deletes it, 
# and your sensitive information may be rendered by a certain blogdown::hugo_build() call last time and left in the directory.

# Nb public folder staat NIET onder versie beheer.

#deleten public folder voordat we hugo_build doen
unlink("public/*", recursive = TRUE)

# MANUAL STEP: COPY IMAGES TO STATIC/POST AND FIND/REPLACE LINKS IN RMD
# re render blog post to HTML

#Always run blogdown::hugo_build() before you upload this directory to a web server.

blogdown::hugo_build()
print("site build")

# zet public folder online

# then go to update_blog.sh

# PM remove Tilburg affil, add link to BB private site