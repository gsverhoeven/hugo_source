library(blogdown)
setwd("C:/hugo/sites/gsverhoeven.github.io")
blogdown::serve_site()

# blogdown:::new_post_addin()
#blogdown::new_post("newrmd", ext = '.Rmd')

#build_site()

# does not compile Rmds
#hugo_build()

# only runs hugo_build()
#serve_site()

# After compilation, go to public folder repo. delete all current contents, except .git

# copy the hugo generated public folder to the public folder repo.
# Delete all .rds files (they  are huge)

# Commit, it diffs automatically.
# Push to github pages.
