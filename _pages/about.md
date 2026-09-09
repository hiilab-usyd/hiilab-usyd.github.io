---
layout: about
title: home
permalink: /
subtitle: Advancing healthcare through extended reality (XR) and interactive technologies

hero_image: hii-lab-logo.png
hide_title: true


selected_papers: true # includes a list of papers marked as "selected={true}"
social: true # includes social icons at the bottom of the page

announcements:
  enabled: true 
  scrollable: true
  limit: 5

latest_posts:
  enabled: false
  scrollable: true
  limit: 3
---
## Welcome to the Health & Immersive Interaction (HII) Lab

The Health & Immersive Interaction (HII) Lab is a multidisciplinary research group based at the Westmead Health Precinct. Our mission is to improve healthcare experiences, medical training, and patient care by combining extended reality (XR) with interactive technologies.

We work at the intersection of clinicians, patients, engineers, designers, and healthcare professionals, collaborating across disciplines to develop and evaluate new health technologies that shape the future of digital health.

{% assign themes = site.data.themes | sort: "order" %}

<div class="home-themes">
{% for t in themes %}
<a class="home-theme" href="{{ '/research/themes/' | relative_url }}">
  <i class="{{ t.icon }}" aria-hidden="true"></i>
  <span>{{ t.name }}</span>
</a>
{% endfor %}
</div>

{% assign featured = site.projects | where: "featured", true | sort: "importance" %}
{% if featured != blank %}

<h2 class="home-heading">Selected work</h2>

<div class="home-work">
{% for p in featured limit: 4 %}
{% assign first_slug = p.themes | first %}
{% assign ft = themes | where: "slug", first_slug | first %}
<a class="home-work-card" href="{{ p.url | relative_url }}">
  {% if p.image %}
  <img class="home-work-img" src="{{ p.image | prepend: '/assets/img/projects/' | relative_url }}" alt="{{ p.title }}" loading="lazy">
  {% else %}
  <div class="home-work-img home-work-ph"><i class="{{ ft.icon | default: 'fa-solid fa-flask' }}" aria-hidden="true"></i></div>
  {% endif %}
  <div class="home-work-body">
    <div class="home-work-title">{{ p.title }}</div>
    {% if p.summary %}<p class="home-work-summary">{{ p.summary | truncate: 110 }}</p>{% endif %}
  </div>
</a>
{% endfor %}
</div>

<p class="home-more"><a href="{{ '/projects/' | relative_url }}">All projects</a></p>

{% endif %}

<style>
.home-themes {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
  gap: 0.6rem;
  margin: 1.75rem 0 0.5rem;
}
.home-theme {
  display: flex;
  align-items: center;
  gap: 0.65rem;
  padding: 0.7rem 0.9rem;
  border: 1px solid var(--global-divider-color);
  border-radius: 8px;
  color: inherit;
  font-size: 0.88rem;
  line-height: 1.3;
  transition: border-color 0.15s ease;
}
.home-theme:hover {
  border-color: var(--global-theme-color);
  color: inherit;
  text-decoration: none;
}
.home-theme i {
  color: var(--global-theme-color);
  font-size: 1.05rem;
  flex-shrink: 0;
}
.home-heading {
  margin-top: 2.75rem;
  margin-bottom: 1rem;
  padding-bottom: 0.4rem;
  border-bottom: 1px solid var(--global-divider-color);
  font-size: 1.35rem;
}
.home-work {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
  gap: 1.1rem;
}
.home-work-card {
  display: flex;
  flex-direction: column;
  border: 1px solid var(--global-divider-color);
  border-radius: 10px;
  overflow: hidden;
  background: var(--global-card-bg-color);
  color: inherit;
  transition: box-shadow 0.2s ease, transform 0.2s ease;
}
.home-work-card:hover {
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
  transform: translateY(-2px);
  color: inherit;
  text-decoration: none;
}
.home-work-img {
  width: 100%;
  aspect-ratio: 16 / 9;
  object-fit: cover;
}
.home-work-ph {
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--global-bg-color);
  color: var(--global-theme-color);
  font-size: 1.8rem;
}
.home-work-body { padding: 0.85rem 1rem 1rem; }
.home-work-title { font-weight: 600; font-size: 0.95rem; line-height: 1.3; }
.home-work-summary {
  font-size: 0.82rem;
  line-height: 1.45;
  color: var(--global-text-color-light);
  margin: 0.35rem 0 0;
}
.home-more { margin-top: 1rem; font-size: 0.9rem; }
</style>