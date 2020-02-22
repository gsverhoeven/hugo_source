library(blogdown)
#setwd("~/Documents/Gertjan_MASTER_18gb/Hugo website/hugo_source")
#setwd("~/Documents/Gertjan_MASTER_18gb/Hugo website/My_Website")

blogdown::serve_site()

#blogdown::build_site()

#This function recompiles all R Markdown files by default, even if the output files are newer than the source files. 
#If you want to build the site without rebuilding all R Markdown files, you should use hugo_build() instead.




# After compilation, go to public folder repo. delete all current contents, except .git

# copy the hugo generated public folder to the public folder repo.
# Delete all .rds files (they  are huge)

# Commit, it diffs automatically.
# Push to github pages.
