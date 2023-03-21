# Parallelization in Seurat

It uses the [Future](https://www.futureverse.org) framework. In R, there are other options to execute tasks in parallel, this one is focused on having a 'simple' interface for programmers, and support multiple platforms (Linux, Windows, MacOSX). If you like base R `lapply()` there is a corresponding `future_lapply()` in the `future.apply` package and if you like tidyverse `purrr::map()` there is a corresponding `future_map()` in the `furrr` package. If you prefer `foreach()` from foreach, then `doFuture` provides a backend adapter!

The following functions take advantage of the Future framework: NormalizeData, ScaleData, JackStraw, FindMarkers, FindIntegrationAnchors, FindClusters.

## Plan(s)

These are set with `future::plan()`. Among others, we have:

- multisession: Resolves futures asynchronously (in parallel) in separate R sessions running in the background on the same machine.

- multicore: Resolves futures asynchronously (in parallel) in separate forked R processes running in the background on the same machine. (Doesn't work on MS Windows.)

## Memory

Each worker (session/ core) needs access to certain global variables, these 'exportation' is done automatically, and it uses a default size of 500 MiB. If the objects don't fit, we'd get an error. Use `options(future.globals.maxSize = 2000 * 1024^2)` to increase this limit to 2 GiB. Be advised, increasing this in excess can be dangerous, specially if you plan to use way too many workers.
