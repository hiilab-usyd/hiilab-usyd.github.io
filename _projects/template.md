---
layout: project
published: false
title: Project title goes here
status: active
summary: One or two sentences. This is what shows on the projects page card.
themes: [immersive-training, clinical-workflow]
image:
lead: Your Name Here
members:
  - Example Postdoc
  - Example PhD Candidate
partners:
  - Westmead Hospital
grants: [example-grant]
start: 2025-01
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
- `grants` are ids from `_data/grants.yml`. Leave the brackets empty if unfunded.
- `image` is a filename in `assets/img/projects/`. Leave blank for no image.
- `end` blank means ongoing.
- `importance` orders the cards. Lower numbers come first.