# PoissonCassant — Mobile Fishing Game

PoissonCassant is a mobile game prototype about fishing and light social interactions, inspired by titles like Animal Crossing. The project is built with Godot Engine and targets mobile (configured in [`project.godot`](project.godot) — see [`run/main_scene`](project.godot)).

Links
- Documentation (MkDocs): See the docs site source at [`https://JonthanUTF.github.io/mirror_PoissonCassant/`](PoissonCassantDocumentation).

Quick start — open & run with Godot
1. Install Godot 4.x (desktop or export templates for mobile).
2. Open the project:
   - Open Godot and select "Import" → choose the project folder that contains [`project.godot`](project.godot).
   - Or from command line (desktop run):
     ```bash
     godot --path . --editor
     ```
3. Run the main scene:
   - The configured main scene is [`scene/main/main.tscn`](scene/main/main.tscn). In the editor press Play (F5) or run:
     ```bash
     godot --path . --main-pack scene/main/main.tscn
     ```
   - For headless test runs (CI style):
     ```bash
     godot --headless --run-tests
     ```

Notes
- Project docs are served with MkDocs (see [mkdocs.yml](http://_vscodecontentref_/0)). To preview locally:
  ```bash
  pip install mkdocs mkdocs-material
  mkdocs serve
  ```