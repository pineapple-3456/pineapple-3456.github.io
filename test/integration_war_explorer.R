# 从仓库根目录运行：Rscript test/integration_war_explorer.R。
source("shiny/war-explorer/app.R", chdir = TRUE)
city_period_counts <- read_csv("shiny/war-explorer/data/war_count_by_city_period.csv",
  col_types = cols(.default = col_character()))

all_records <- filter_records(year_limits, c("战斗", "非战斗"))
stopifnot(
  nrow(all_records) == 10725L,
  n_distinct(all_records$战争序号) == 3752L,
  !anyNA(all_records$year),
  all(year_limits == c(-769, 1911)),
  !anyDuplicated(all_records[c("战争序号", "当代地级市")]),
  sum(is.na(all_records$map_code)) == 245L,
  sum(count_map_records(all_records)$war_count) == 10480L,
  "710000" %in% city_map$map_code,
  sum(all_records$map_code == "710000", na.rm = TRUE) == 86L,
  nrow(filter_records(year_limits, "战斗")) == 7756L,
  nrow(filter_records(year_limits, "非战斗")) == 2969L,
  nrow(filter_records(year_limits, character())) == 0L,
  nrow(filter_records(c(-769, -769), "战斗")) == 1L,
  nrow(filter_records(c(0, 0), c("战斗", "非战斗"))) == 0L
)

# 投影保持台湾几何与输入记录完整，界面保留明细表并移除汇总及计数说明。
projected_cities <- st_transform(city_map, china_crs)
stopifnot(
  nrow(projected_cities) == nrow(city_map),
  all(is.finite(st_coordinates(projected_cities))),
  !st_is_empty(projected_cities[projected_cities$map_code == "710000", ])
)
ui_html <- as.character(ui)
stopifnot(
  grepl("https://github.com/pineapple-3456/chinese-historical-wars", ui_html, fixed = TRUE),
  !grepl("summary_table|selection_count|map_note|同一战争在同一城市计1次", ui_html)
)

# 汇总原表与明细按城市、历史阶段逐项对照，不把境外或待考记录塞进城市。
for (period in names(city_period_counts)[5:(ncol(city_period_counts) - 1)]) {
  observed <- all_records |>
    filter(历史阶段 == period) |>
    count(当代地级市, name = "observed")
  comparison <- city_period_counts |>
    left_join(observed, by = c("地级市" = "当代地级市"))
  stopifnot(all(as.integer(comparison[[period]]) == coalesce(comparison$observed, 0L)))
}

testServer(server, {
  session$setInputs(years = c(-769, 1911), location_types = c("战斗", "非战斗"))
  stopifnot(nrow(selected_records()) == 10725L)
  session$setInputs(years = c(1644, 1911), location_types = "战斗")
  selected <- selected_records()
  stopifnot(nrow(selected) > 0L, all(selected$year >= 1644), all(selected$类型 == "战斗"))
  session$setInputs(location_types = character())
  stopifnot(nrow(selected_records()) == 0L)
})

cat("战争探索：计数、地图匹配、逐阶段原表核对与响应式筛选检查通过。\n")
