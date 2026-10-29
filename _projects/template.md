---
layout: project
published: false
title: Project title goes here
status: active
featured: false
summary: One or two sentences. This is what shows on the projects page card.
themes: [immersive-training, clinical-workflow]
image:
lead: Your Name Here
members:
  - Lab member name
collaborators:
  - name: Person outside the lab
    url: https://example.org/their-profile
    affiliation: Their university or organisation
institutions:
  - name: Partner organisation
    url: https://example.org
grants: []
start: 2026-01
end:
importance: 1
---

The body is normal markdown. Write as much or as little as you like.
Headings, images, and links all work.

Notes for whoever is adding a project:

- The filename becomes the web address. `airway-vr.md` gives `/projects/airway-vr/`.
- Delete `published: false` when the project is ready to go live.
- `status` is `active` or `completed`.
- `themes` are slugs from `_data/themes.yml`.
- `members` are lab members. Use the same spelling as in `_data/members.yml`.
- `collaborators` are people outside the lab. `institutions` are partner
  organisations. For both, `url` is optional, and so is `affiliation` on a
  collaborator. A plain name on its own line also works: `- Jane Smith`.
  Delete either list if there is nobody to name yet.
- `grants` are ids from `_data/grants.yml`. Leave the brackets empty if unfunded.
- `image` is a filename in `assets/img/projects/`. Upload the image first,
  then fill this in. Leave blank for no image.
- `end` blank means ongoing.
- `importance` orders the cards. Lower numbers come first.
- `featured: true` puts the project on the front page. Keep it to three or four.
