plot_performance <- function(data, axis_label = "", plot_title = "") {
  ggplot(data, 
         aes(x = reorder(algo, performance), y = performance*100, col = factor(algo))) +
    geom_point() +
    geom_segment(aes(xend = algo, y = 0, yend = performance*100)) +
    geom_label(aes(label = paste0(round(performance*100,0), "%")), nudge_y = -0.02, nudge_x = +0.2) +
    coord_flip() +
    facet_wrap(~ ds_name) +
    scale_y_continuous(expand = c(0.2,0))+
    labs(y = axis_label, x = "", title = plot_title)
}
