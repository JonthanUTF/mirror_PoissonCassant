# Guide du collaborateur

Bienvenue dans le guide pour contribuer à ce projet.  
Ce document explique les normes de commit, la gestion des Pull Requests (PR), des issues, et les règles de branches.

---

## 1️⃣ Norme de commit

Nous utilisons la **Convention des commits (Conventional Commits)** pour que le versioning et le changelog soient automatiques.

**Format :**

```
<type>(<scope>): <subject>

[body]

BREAKING CHANGE: <description of breaking change>
```

Exemples :

```
feat(fishing): ajouter le mini-jeu de pêche et récompenses
fix(inventory): empêcher l'ajout d'un item quand l'inventaire est plein
docs(readme): ajouter les instructions d'installation
```

Bonnes pratiques pour le message de commit :
- Utiliser l'impératif et une ligne de titre courte (< 72 caractères)
- Mettre le scope quand c'est pertinent (ex: `player`, `ui`, `fishing`)
- Ajouter un corps si le changement nécessite des explications
- Utiliser `BREAKING CHANGE:` si vous modifiez une API ou un format

**Types principaux :**

| Type     | Scope | Exemple |
|----------|-------|---------|
| feat     | fishing | feat(fishing): ajout du système de pêche aléatoire |
| fix      | inventory | fix(inventory): correction crash quand inventaire plein |
| docs     | readme | docs(readme): mise à jour des instructions d'installation |
| chore    | build | chore(build): mise à jour des dépendances |
| refactor | npc | refactor(npc): simplification du dialogue des quêtes |
| test     | fishing | test(fishing): ajout de tests unitaires |

**Breaking change :**

→ Cela génère une version majeure (1.0.0 → 2.0.0).

---

## 2️⃣ Pull Requests (PR)

- **Toujours créer une PR depuis une branche `feature/*` ou `dev`**.
- PR → doit être mergée vers **`dev`**, jamais directement sur `main`.
- PR → doivent inclure :
  - Un titre clair et concis
  - Une description complète des changements
  - Les issues associées (voir section suivante)
- Après validation et tests → `dev` merge vers `main` via PR.

**Template PR :**

Voici un template simple que vous pouvez copier dans la description d'une PR :

```
Titre: feat(<scope>): courte description

Description:
- Qu'est-ce qui a été changé ?
- Pourquoi ?

Issues liées:
- Closes #<num> (le cas échéant)

Checklist:
- [ ] Code formaté et lint passé
- [ ] Tests unitaires ajoutés / mis à jour (si applicable)
- [ ] Documentation mise à jour (si applicable)
```

Règles PR:
- Toujours créer une branche `feature/*` ou `fix/*` depuis `dev`.
- Faire une PR vers `dev` (ne pas merger directement sur `main`).
- Ajouter une description claire et lister les issues fermées avec `Closes #<num>`.

---

## 3️⃣ Issues

- **Toujours créer une issue pour un bug ou une nouvelle feature**
- Tags recommandés :
  - `bug` pour les bugs
  - `enhancement` pour les nouvelles fonctionnalités
  - `documentation` pour les docs
  - `question` pour les questions
- Lier les issues aux PRs : ajoute `Closes #<numéro>` dans la PR pour fermer automatiquement l’issue lors du merge.

**Exemple :**

Exemple d'issue pour un bug :

```
Titre: [BUG] Le joueur peut traverser certains obstacles

Description:
- Étapes pour reproduire:
  1. Charger la scène `map.tscn`
  2. Aller à l'emplacement X
  3. Tenter d'entrer en collision
- Comportement attendu: le joueur est bloqué par le collider
- Comportement observé: le joueur traverse le collider

Logs / capture: (si disponible)
```

Exemple d'issue feature (utiliser le formulaire `feature_request` créé):

```
Titre: [FEATURE][Player] Améliorer le système de pêche

Contexte:
- Le système actuel est basique et manque de feedback.

Comportement attendu:
- Ajouter un mini-jeu de timing
- Donner des récompenses selon la difficulté

Dépendances:
- #12 (création des assets de pêche)
```

---

## 4️⃣ Branches

- `main` → version stable / production. **Ne pas push direct !**
- `dev` → version de développement intégrant toutes les features validées
- `feature/*` → nouvelles fonctionnalités ou corrections
- Règles :
  - Protection des branches activée (`main` et `dev`)
  - `dev` → PR obligatoire pour merger vers `main`
  - PR directe vers `main` bloquée si elle ne vient pas de `dev`

Remarques pratiques :
- Nommer les branches `feature/<courte-description>` ou `fix/<courte-description>`.
- Rebase ou merge `dev` souvent pour limiter les conflits.

---

## 5️⃣ Bonnes pratiques

- Pull régulièrement les changements (`git pull`) pour éviter les conflits
- Faire des commits **petits et logiques**
- Vérifier que les tests passent avant de créer une PR
- Utiliser des messages clairs pour les commits et PR
- Toujours relire et commenter les PRs de tes collègues

Checklist contribution (avant de soumettre une PR) :
- [ ] Le code compile et fonctionne localement
- [ ] Les tests automatiques passent (si présents)
- [ ] Le message de commit respecte la convention
- [ ] La PR contient une description et les issues liées
- [ ] Les assets ajoutés sont dans `asset/` ou `docs/assets/` selon le cas

Comment contribuer (workflow rapide) :
1. Forker (si tu n'as pas d'accès direct) puis cloner le repo
2. Créer une branche: `git checkout -b feature/ma-feature`
3. Faire de petits commits clairs
4. Pousser et ouvrir une PR vers `dev`

Si tu veux contribuer au contenu de la doc locale :
- Installer mkdocs (ou utiliser pipx) puis lancer :

```bash
mkdocs serve
# ou avec pipx : pipx run mkdocs serve
```

Le site de développement sera disponible sur http://127.0.0.1:8000/ ; édite les fichiers dans `docs/` et vérifie le rendu.

---

## 6️⃣ Liens utiles

- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitHub Actions](https://docs.github.com/en/actions)
- [GitHub Flow](https://guides.github.com/introduction/flow/)

