---
layout: page
title: 历代战争探索
description: 探索中国历代战争空间分布
permalink: /war-explorer/
nav: false
---

{% if site.war_explorer_url and site.war_explorer_url != "" %}

<iframe
  src="{{ site.war_explorer_url | escape }}"
  title="历代战争次数交互地图与原始数据"
  width="100%"
  height="1750"
  style="border: 0"
  loading="eager"
></iframe>

<p><a href="{{ site.war_explorer_url | escape }}" target="_blank" rel="noopener">在独立窗口中打开探索页面 ↗</a></p>

{% else %}

探索中国历代战争空间分布

交互应用正在本地预览，公开服务尚未配置。

{% endif %}
