# this compiles all Rmds  and fills ./public in hugo_source

#blogdown::build_site()
#blogdown:::build_rmds("content/post/2020-12-30-jacks_car_rental_gym.Rmd")
#blogdown:::build_rmds("content/post/2021_03_07_qlearning_frozenlake_convergence.Rmd")
#blogdown:::build_rmds("content/post/2021-05-02-workflow_scientific_papers.Rmd")
#blogdown:::build_rmds("content/post/2021_05_14_covid_rapid_test_reliability.Rmd")
blogdown::hugo_build()
print("site build")

