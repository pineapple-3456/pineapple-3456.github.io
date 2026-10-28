# 历代战争探索

使用 Shiny 默认布局。黑白市级地图占满页面宽度，年份滑块与地点类型多选置于地图下方，联动更新地图和战争地点明细。下方提供[数据下载](https://github.com/pineapple-3456/chinese-historical-wars)链接。

## 本地运行

需要 R，以及 `shiny`、`dplyr`、`readr`、`sf`、`ggplot2`、`reactable`、`ragg`。图中文字使用系统默认无衬线字体，由 `ragg` 渲染。从网站仓库根目录运行：

```r
shiny::runApp("shiny/war-explorer", host = "127.0.0.1", port = 3838)
```

## 数据口径

- `data/war_list_brief.csv`：10,725 条地点记录，3,752 场战争；年份为公元前 769 年至 1911 年。
- 地图按所选年份（含起止年）与地点类型计数。一行是一场战争在一个城市的地点记录；一场战争涉及多个城市时各计一次。
- 年份使用原表“公元纪年”，负数表示公元前，不另行推断战争持续时间。
- 238 条“境外”与 7 条“待考”记录保留在筛选明细、战争场数和地点记录数中，不绘入城市地图。
- `data/中国_市.geojson` 的台湾面为省级，因此台湾市县的 86 条记录在地图中按省汇总。表格保留原市县。
- 地图采用 Albers 等积圆锥投影，中央经线105°E、标准纬线25°N和47°N，椭球体为GRS80；参数参见[官方全国土壤制图技术文件](https://nyncw.cq.gov.cn/ztzl_161/rdzt/dscqgtrpc_347647/zcwj_347648/202209/P020220907559130654365.pdf)中的“国家土壤制图采用的地图投影参数”表。
- `data/war_count_by_city_period.csv` 原表保留，程序测试将其各市、各历史阶段计数与明细逐项核对；页面只显示战争地点明细。
- 三份输入均为用户所提供文件的副本。资料来源为解放军出版社《中国历代战争年表》上下册，依据输入数据仓库的 README。

## 网站接入

`_pages/dropdown.md` 的子菜单链接指向 `/war-explorer/`，原有博客文章与独立 blog 导航保留。

GitHub Pages 生成静态页面，R Shiny 应用需单独部署到支持 R 的服务。部署后将 HTTPS 地址填入 `_config.yml` 的 `war_explorer_url`，网站以 iframe 嵌入应用。`shiny/` 已从 Jekyll 输出排除。

本地预览通过临时配置将 `war_explorer_url` 设为 `http://127.0.0.1:3838/`；正式配置不保存本机地址。嵌入服务需要允许本站 iframe 与 WebSocket 连接。

主题的内容安全策略允许同源与 HTTPS iframe。本次 HTTP 本地预览仅在 `/tmp` 的生成页面中，为 `frame-src` 追加 `http://127.0.0.1:3838`；正式模板保持原样。

## 验证

```bash
Rscript test/integration_war_explorer.R
```

交互控件参见 [Shiny 官方文档](https://shiny.posit.co/r/components/inputs/checkbox-group/)。
