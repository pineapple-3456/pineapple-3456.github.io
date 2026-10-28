library(shiny)
library(dplyr)
library(readr)
library(sf)
library(ggplot2)
library(reactable)
library(ragg)

# 每行是一场战争在一个当代城市的地点记录；同一战争可涉及多个城市。
war_records <- read_csv("data/war_list_brief.csv", col_types = cols(.default = col_character()))
map_source <- st_read("data/中国_市.geojson", quiet = TRUE) |> st_transform(4326)
city_map <- map_source[st_geometry_type(map_source) == "MULTIPOLYGON", ] |>
  mutate(map_code = substring(gb, 4))
boundary_lines <- map_source[st_geometry_type(map_source) == "MULTILINESTRING", ]
# 全国专题图采用 Albers 等积圆锥投影，中央经线105°E，标准纬线25°N和47°N。
china_crs <- st_crs("+proj=aea +lat_1=25 +lat_2=47 +lat_0=0 +lon_0=105 +ellps=GRS80 +units=m +no_defs")

# 年份沿用原表，公元前用负数表示。所给地图中的台湾为省级面，市县记录在此合并计数。
war_records <- war_records |>
  mutate(
    year = parse_number(公元纪年) * if_else(grepl("^前", 公元纪年), -1, 1),
    map_code = case_when(
      省级行政区 == "台湾省" ~ "710000",
      行政区划代码 %in% city_map$map_code ~ 行政区划代码,
      TRUE ~ NA_character_
    )
  )
year_limits <- range(war_records$year)
record_columns <- setdiff(names(war_records), c("year", "map_code", "原书页码"))
year_label <- function(year) ifelse(year < 0, paste0("公元前", abs(year), "年"), paste0("公元", year, "年"))
filter_records <- function(years, types) {
  war_records |> filter(year >= years[1], year <= years[2], 类型 %in% types)
}
count_map_records <- function(records) {
  records |> filter(!is.na(map_code)) |> count(map_code, name = "war_count")
}

ui <- fluidPage(
  titlePanel("历代战争次数"),
  plotOutput("war_map", height = "720px"),
  wellPanel(
    fluidRow(
      column(8,
        sliderInput("years", "时间范围", min = year_limits[1], max = year_limits[2],
          value = year_limits, step = 1, sep = "", width = "100%"),
        helpText("负数表示公元前，起止年份均计入。")
      ),
      column(4,
        checkboxGroupInput("location_types", "地点类型（可多选）",
          c("战斗地点" = "战斗", "非战斗地点" = "非战斗"),
          selected = c("战斗", "非战斗"), inline = TRUE)
      )
    )
  ),
  p(a("数据下载", href = "https://github.com/pineapple-3456/chinese-historical-wars",
    target = "_blank", rel = "noopener")),
  h3("原始数据"),
  textOutput("table_count"),
  reactableOutput("records_table"),
  hr(),
  p("资料来源：解放军出版社《中国历代战争年表》上下册。")
)

server <- function(input, output, session) {
  selected_records <- reactive({
    req(input$years)
    filter_records(input$years, input$location_types)
  })
  output$war_map <- renderPlot({
    mapped <- city_map |> left_join(count_map_records(selected_records()), by = "map_code") |>
      mutate(war_count = coalesce(war_count, 0L))
    ggplot(mapped) +
      geom_sf(aes(fill = war_count), colour = "grey55", linewidth = 0.15) +
      geom_sf(data = boundary_lines, colour = "grey35", linewidth = 0.2) +
      scale_fill_gradient(low = "white", high = "black", name = "战争次数",
        limits = c(0, max(1, mapped$war_count))) +
      coord_sf(crs = china_crs, default_crs = st_crs(4326),
        xlim = c(73, 136), ylim = c(16, 54), lims_method = "box", expand = FALSE, datum = NA) +
      labs(title = paste(year_label(input$years), collapse = "—")) +
      theme_void(base_family = "sans") +
      theme(plot.title = element_text(hjust = 0.5))
  }, res = 120)
  output$table_count <- renderText(paste0("当前筛选：", nrow(selected_records()), "条地点记录"))
  output$records_table <- renderReactable({
    reactable(selected_records() |> select(all_of(record_columns)),
      searchable = TRUE, defaultPageSize = 10, showPageSizeOptions = TRUE,
      defaultColDef = colDef(minWidth = 120),
      columns = list(战争名称 = colDef(minWidth = 240), 当时地名 = colDef(minWidth = 280)))
  })
}

shinyApp(ui, server)
