---
layout: page
permalink: /publications/
title: publications
description: Peer-reviewed papers, posters, and preprints from the HII Lab.
nav: false
---

<script type="application/json" id="pub-meta">
[{% bibliography --template bib_meta --group_by none %}{"key":"__end__","pubtype":"","topics":""}]
</script>

<script type="application/json" id="pub-themes">
[{% for t in site.data.themes %}{"slug":"{{ t.slug }}","name":"{{ t.short | default: t.name }}"}{% unless forloop.last %},{% endunless %}{% endfor %}]
</script>

<div class="pub-counters" id="pub-counters"></div>

<div class="pub-controls">
<div class="pub-tabs" id="pub-tabs"></div>
<div class="pub-topics" id="pub-topics"></div>
</div>

{% include bib_search.liquid %}

<div class="publications">

{% bibliography %}

</div>

<script>
(function () {
  var TYPES = [
    { id: "all", label: "All" },
    { id: "conference-journal", label: "Conference & Journal" },
    { id: "poster-demo-workshop", label: "Poster, Demo & Workshop" },
    { id: "preprint", label: "Preprint" },
    { id: "submitted", label: "Submitted" }
  ];

  function readJSON(id) {
    var el = document.getElementById(id);
    if (!el) return [];
    try { return JSON.parse(el.textContent.trim()); } catch (e) { return []; }
  }

  var meta = readJSON("pub-meta").filter(function (m) { return m.key !== "__end__"; });
  var themes = readJSON("pub-themes");

  // Attach type and topics to each rendered entry.
  var entries = [];
  meta.forEach(function (m) {
    var node = document.getElementById(m.key);
    if (!node) return;
    var li = node.closest("li") || node.closest(".row");
    if (!li) return;
    li.dataset.pubtype = m.pubtype || "other";
    li.dataset.topics = (m.topics || "")
      .split(",")
      .map(function (s) { return s.trim(); })
      .filter(Boolean)
      .join("|");
    entries.push(li);
  });

  var state = { type: "all", topic: "all" };

  var params = new URLSearchParams(window.location.search);
  if (params.get("topic")) state.topic = params.get("topic");
  if (params.get("type")) state.type = params.get("type");

  // Counters
  function countOf(type) {
    if (type === "all") return meta.length;
    return meta.filter(function (m) { return m.pubtype === type; }).length;
  }

  var counters = document.getElementById("pub-counters");
  counters.innerHTML = TYPES.map(function (t) {
    return '<div class="pub-counter"><span class="pub-counter-n">' +
      countOf(t.id) + '</span><span class="pub-counter-l">' +
      (t.id === "all" ? "Total papers" : t.label) + "</span></div>";
  }).join("");

  // Tabs
  var tabsEl = document.getElementById("pub-tabs");
  tabsEl.innerHTML = TYPES.map(function (t) {
    return '<button type="button" class="pub-tab" data-type="' + t.id + '">' +
      t.label + "</button>";
  }).join("");

  // Topic chips
  var topicsEl = document.getElementById("pub-topics");
  if (themes.length) {
    topicsEl.innerHTML =
      '<button type="button" class="pub-chip" data-topic="all">All topics</button>' +
      themes.map(function (t) {
        return '<button type="button" class="pub-chip" data-topic="' + t.slug + '">' +
          t.name + "</button>";
      }).join("");
  }

  function apply() {
    entries.forEach(function (li) {
      var okType = state.type === "all" || li.dataset.pubtype === state.type;
      var list = (li.dataset.topics || "").split("|");
      var okTopic = state.topic === "all" || list.indexOf(state.topic) !== -1;
      li.style.display = okType && okTopic ? "" : "none";
    });

    // Hide year headings that have nothing left under them.
    document.querySelectorAll(".publications ol.bibliography").forEach(function (ol) {
      var visible = Array.prototype.filter.call(ol.children, function (li) {
        return li.style.display !== "none";
      }).length;
      ol.style.display = visible ? "" : "none";
      var h = ol.previousElementSibling;
      if (h && h.tagName === "H2") h.style.display = visible ? "" : "none";
    });

    document.querySelectorAll(".pub-tab").forEach(function (b) {
      b.classList.toggle("active", b.dataset.type === state.type);
    });
    document.querySelectorAll(".pub-chip").forEach(function (b) {
      b.classList.toggle("active", b.dataset.topic === state.topic);
    });
  }

  tabsEl.addEventListener("click", function (e) {
    var b = e.target.closest(".pub-tab");
    if (!b) return;
    state.type = b.dataset.type;
    apply();
  });

  topicsEl.addEventListener("click", function (e) {
    var b = e.target.closest(".pub-chip");
    if (!b) return;
    state.topic = b.dataset.topic;
    apply();
  });

  apply();
})();
</script>

<style>
.pub-counters {
  display: flex;
  flex-wrap: wrap;
  gap: 1.5rem;
  padding: 1rem 0 1.25rem;
  border-bottom: 1px solid var(--global-divider-color);
  margin-bottom: 1.25rem;
}
.pub-counter {
  display: flex;
  flex-direction: column;
  min-width: 90px;
}
.pub-counter-n {
  font-size: 1.7rem;
  font-weight: 700;
  line-height: 1.1;
  color: var(--global-theme-color);
}
.pub-counter-l {
  font-size: 0.72rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  color: var(--global-text-color-light);
  margin-top: 0.15rem;
}
.pub-controls {
  margin-bottom: 1.25rem;
}
.pub-tabs,
.pub-topics {
  display: flex;
  flex-wrap: wrap;
  gap: 0.4rem;
}
.pub-topics {
  margin-top: 0.5rem;
}
.pub-tab,
.pub-chip {
  border: 1px solid var(--global-divider-color);
  background: transparent;
  color: var(--global-text-color);
  border-radius: 999px;
  padding: 0.28rem 0.8rem;
  font-size: 0.82rem;
  cursor: pointer;
  line-height: 1.4;
}
.pub-tab:hover,
.pub-chip:hover {
  border-color: var(--global-theme-color);
  color: var(--global-theme-color);
}
.pub-tab.active,
.pub-chip.active {
  background: var(--global-theme-color);
  border-color: var(--global-theme-color);
  color: #fff;
}
.pub-chip {
  font-size: 0.78rem;
  padding: 0.22rem 0.7rem;
}
.publications .author em {
  font-style: normal;
  font-weight: 700;
}
@media (max-width: 576px) {
  .pub-counters {
    gap: 1rem;
  }
  .pub-counter-n {
    font-size: 1.35rem;
  }
}
</style>