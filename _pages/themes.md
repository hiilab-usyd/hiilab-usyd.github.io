---
layout: page
title: research themes
permalink: /research/themes/
description: What we work on, and who works on it.
nav: false
---

{% assign themes = site.data.themes | sort: "order" %}

<div class="theme-grid">
{% for theme in themes %}
  {% assign slug = theme.slug %}
  {% assign people = site.data.members | where_exp: "m", "m.themes contains slug" %}
  {% assign people = people | where_exp: "m", "m.alumni != true" %}
  {% assign theme_grants = site.data.grants | where_exp: "g", "g.themes contains slug" %}
  <div class="theme-card">
    <div class="theme-head">
      <i class="{{ theme.icon }} theme-icon" aria-hidden="true"></i>
      <h2 class="theme-name">{{ theme.name }}</h2>
    </div>
    <p class="theme-desc">{{ theme.description }}</p>

    {% if people.size > 0 %}
    <div class="theme-block">
      <div class="theme-label">People</div>
      <div class="theme-avatars">
        {% for m in people limit: 6 %}
          {% if m.image %}{% assign img = m.image | prepend: '/assets/img/people/' %}{% else %}{% assign img = '/assets/img/people/person-placeholder.png' %}{% endif %}
          <a href="{{ '/team/' | relative_url }}" title="{{ m.name }}">
            <img class="theme-avatar" src="{{ img | relative_url }}" alt="{{ m.name }}" loading="lazy">
          </a>
        {% endfor %}
        {% if people.size > 6 %}<span class="theme-more">+{{ people.size | minus: 6 }}</span>{% endif %}
      </div>
    </div>
    {% endif %}

    <div class="theme-foot">
      <a class="theme-link" href="{{ '/publications/' | relative_url }}?topic={{ slug }}">Publications</a>
      {% if theme_grants.size > 0 %}
      <span class="theme-meta">{{ theme_grants.size }} grant{% if theme_grants.size != 1 %}s{% endif %}</span>
      {% endif %}
    </div>
  </div>
{% endfor %}
</div>

<style>
.theme-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
  gap: 1.5rem;
  margin-top: 1.5rem;
}
.theme-card {
  display: flex;
  flex-direction: column;
  padding: 1.4rem 1.4rem 1.1rem;
  border: 1px solid var(--global-divider-color);
  border-radius: 10px;
  background: var(--global-card-bg-color);
  transition: box-shadow 0.2s ease, transform 0.2s ease;
}
.theme-card:hover {
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
  transform: translateY(-2px);
}
.theme-head {
  display: flex;
  align-items: center;
  gap: 0.7rem;
  margin-bottom: 0.6rem;
}
.theme-icon {
  font-size: 1.35rem;
  color: var(--global-theme-color);
  flex-shrink: 0;
}
.theme-name {
  font-size: 1.1rem;
  font-weight: 600;
  margin: 0;
  line-height: 1.3;
}
.theme-desc {
  font-size: 0.9rem;
  line-height: 1.5;
  color: var(--global-text-color-light);
  margin-bottom: 1rem;
}
.theme-block {
  margin-bottom: 1rem;
}
.theme-label {
  font-size: 0.7rem;
  text-transform: uppercase;
  letter-spacing: 0.06em;
  color: var(--global-text-color-light);
  margin-bottom: 0.45rem;
}
.theme-avatars {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 0.35rem;
}
.theme-avatar {
  width: 38px;
  height: 38px;
  border-radius: 50%;
  object-fit: cover;
  border: 2px solid var(--global-bg-color);
}
.theme-more {
  font-size: 0.8rem;
  color: var(--global-text-color-light);
  margin-left: 0.2rem;
}
.theme-foot {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 0.75rem;
  margin-top: auto;
  padding-top: 0.8rem;
  border-top: 1px solid var(--global-divider-color);
}
.theme-link {
  font-size: 0.85rem;
  font-weight: 600;
  color: var(--global-theme-color);
}
.theme-meta {
  font-size: 0.78rem;
  color: var(--global-text-color-light);
}
@media (max-width: 480px) {
  .theme-grid {
    grid-template-columns: 1fr;
  }
}
</style>