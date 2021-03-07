# this compiles all Rmds  and fills ./public in hugo_source

#blogdown::build_site()
#blogdown:::build_rmds("content/post/2020-12-30-jacks_car_rental_gym.Rmd")
blogdown:::build_rmds("content/post/2021_03_07_qlearning_frozenlake_convergence.Rmd")
blogdown::hugo_build()
print("site build")

