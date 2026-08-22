---
layout: page
title: team
permalink: /team/
description: The people behind the HII Lab.
nav: true
nav_order: 3
---

{% assign groups = "lead,academic,postdoc,phd,student,staff" | split: "," %}
{% assign labels = "Lab Director,Academic Staff,Postdoctoral Researchers,PhD Candidates,Students,Professional Staff" | split: "," %}
{% for group in groups %}
{% assign members = site.data.members | where: "role", group %}
{% assign current = members | where_exp: "m", "m.alumni != true" %}
{% if current.size > 0 %}
<h2 class="team-heading">{{ labels[forloop.index0] }}</h2>
<div class="team-grid">
{% for m in current %}
{% if m.image %}{% assign img = m.image | prepend: '/assets/img/people/' %}{% else %}{% assign img = '/assets/img/people/person-placeholder.png' %}{% endif %}
<div class="team-card">
<img class="team-photo" src="{{ img | relative_url }}" alt="{{ m.name }}" loading="lazy">
<div class="team-name">{{ m.name }}</div>
{% if m.title %}<div class="team-title">{{ m.title }}</div>{% endif %}
{% if m.interests %}<div class="team-interests">{{ m.interests }}</div>{% endif %}
<div class="team-links">
{% if m.email %}<a href="mailto:{{ m.email }}">email</a>{% endif %}
{% if m.website %}<a href="{{ m.website }}">website</a>{% endif %}
{% if m.scholar %}<a href="{{ m.scholar }}">scholar</a>{% endif %}
</div>
</div>
{% endfor %}
</div>
{% endif %}
{% endfor %}
{% assign alumni = site.data.members | where: "alumni", true %}
{% if alumni.size > 0 %}
<h2 class="team-heading">Alumni</h2>
<ul class="team-alumni">
{% for m in alumni %}
<li><strong>{{ m.name }}</strong>{% if m.title %}, {{ m.title }}{% endif %}{% if m.left %}. {{ m.left }}{% endif %}</li>
{% endfor %}
</ul>
{% endif %}

<style>
.team-heading {
  margin-top: 2.5rem;
  margin-bottom: 1.25rem;
  padding-bottom: 0.4rem;
  border-bottom: 1px solid var(--global-divider-color);
  font-size: 1.35rem;
}
.team-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
  gap: 1.75rem 1.25rem;
}
.team-card {
  text-align: center;
}
.team-photo {
  width: 100%;
  aspect-ratio: 1 / 1;
  object-fit: cover;
  border-radius: 50%;
  background: var(--global-card-bg-color);
  margin-bottom: 0.6rem;
}
.team-name {
  font-weight: 600;
  line-height: 1.25;
}
.team-title {
  font-size: 0.85rem;
  color: var(--global-text-color-light);
  margin-top: 0.15rem;
}
.team-interests {
  font-size: 0.82rem;
  color: var(--global-text-color-light);
  margin-top: 0.35rem;
  line-height: 1.35;
}
.team-links {
  margin-top: 0.45rem;
  font-size: 0.78rem;
}
.team-links a {
  margin: 0 0.3rem;
  color: var(--global-theme-color);
}
.team-alumni {
  line-height: 1.9;
  padding-left: 1.1rem;
}
@media (max-width: 480px) {
  .team-grid {
    grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
  }
}
</style>