# Agent instructions for keyboard-labs

Use this file for day-to-day agent work in this repository.

## Task runner

Prefer **`just`** from the repo root.
Make still owns file-deps for PCB, CAD, and firmware.
Make targets may be called from just recipes or from CI.

```text
just                    # interactive picker (fzf)
just list               # all recipes, including submodules
just fmt                # treefmt (alejandra, rustfmt, shfmt + shellcheck)
just fmt-check          # format check without writing
just check              # nix flake check (PCB kibot on Linux; heavy)
```

Modules: `pcb`, `firmware`, `cad`, `nix`.

### Recipe naming

| Form | Meaning | Examples |
| --- | --- | --- |
| `module::recipe` | Just **submodule** path | `pcb::kibot`, `firmware::build`, `cad::case` |
| `kebab-case` | Multi-word **recipe** names | `fmt-check` |
| `path/to/file` | **Filesystem** only | `mod pcb` → `pcb/justfile` |

## Before you push

CI is [`.github/workflows/nix-flake-check.yml`](.github/workflows/nix-flake-check.yml):
 `nix flake check` on Linux.
That builds the PCB kibot check (`checks.pcb`).

After edits that touch formatted files, and **before pushing**, run:

```sh
just fmt-check
```

Fix with `just fmt`, then re-run `just fmt-check`.

`just check` stands in for CI: every packaged PCB via kibot, Linux-only for those outputs.
Use it when changing Nix packaging, flake modules, or a board in `pcb/default.nix`.
A single board or firmware bin is `just pcb::kibot` / `just firmware::build`;
 `just pcb::all` rebuilds every board.

This flake's source is the git tree.
**New paths are invisible to `nix flake check` / `nix build` until they are staged** (`git add`).

## Broader verification

| Goal | Command |
| --- | --- |
| Format | `just fmt` / `just fmt-check` |
| One PCB (gerbers/docs) | `just pcb::kibot <board>` (chooser if omitted) |
| One PCB PCBA (BOM + CPL) | `just pcb::pcba <board>` |
| One keyberon bin (`.bin` + `.uf2`) | `just firmware::build <bin>` |
| All keyberon firmware | `just firmware::all` |
| One 3D-print case STL | `just cad::case <stem>` |
| Flake check (CI-ish) | `just check` / `just nix::check` |
| PCB / firmware dev shell | `just nix::shell pcb` or `firmware` |

PCB kibot needs the `pcb` dev shell (`nix develop .#pcb` or `just nix::shell pcb`)
 unless `KIBOT` is set to `pcb/run-kibot.sh` / docker / container wrappers.
Keyberon builds need the `firmware-keyberon` shell (`nix develop .#firmware-keyberon`).

## Layout (short)

| Path | Role |
| --- | --- |
| `pcb/` | KiCad boards, kibot, gerbers, PCBA |
| `cad/` | OpenSCAD cases and plates |
| `firmware/keyberon/` | Rust keyberon firmware (this repo's firmware to edit) |
| `firmware/qmk/`, `firmware/vial/` | Snapshots synced from the QMK / Vial forks |
| `firmware/kmk/` | CircuitPython KMK sketches |
| `docs/` | Build guides and photos |
| `nix/` | Flake packages, QMK compile, helpers |
| `scripts/` | ibom, kicad→scad, QMK sync, `kicad_helpers` |
| `.github/workflows/` | CI source of truth |

QMK layouts are developed in the [`qmk_firmware` fork](https://github.com/rgoulter/qmk_firmware)
 on `rgoulter-keyboards-and-layouts`,
 then copied here with `scripts/sync-firmware-*.sh`.
`firmware/qmk` is that snapshot, used by the Nix QMK packages.

## Conventions

- Keep changes focused; match existing style in the file you edit.
- Prefer extending existing Make / just recipes over one-off shell in docs.
- CI calls `nix flake check`; keep flake `checks` and packaged board names stable.
- PCB packages and the `pcb` check are Linux-only (`pcb/flake-module.nix`).
- `scripts/kicad_helpers/` is a functional core / imperative shell:
  pure placement math in the core, board IO in `apply_spec`.

### Git and PRs

- **Organised, atomic commits** — one logical change each.
  Not one commit of everything, and not a new commit per tweak or review comment.
- **Amend or squash** `"fix"`, `"address review"`, `"typo"`, and `"oops"`
  into the commit they belong to.
  An open PR is still work in progress:
  prefer rewriting the branch (amend, squash, restack, force-push)
  over stacking fixup commits.
- **Prefer several smaller, focused PRs**
  over one large PR when the work naturally splits.
- Clear scope and title; no unrelated drive-by changes.
  Don't expand an approved PR — open a follow-up.
- **Attribute agent-assisted commits with trailers** —
  use `git commit --trailer` / `git interpret-trailers`
  to add trailers attributing both the model and the agent harness
  (e.g. `Model: <model-name>` and `Agent: <harness-name>`).
  Also add `Co-Authored-By:` for each, since GitHub surfaces that in the UI.

### Prose

These rules apply to README, build guides, and other user-facing markdown.
Dry and boring is acceptable.
Commit messages follow the Git and PRs section.

After a draft, re-read for stacked short sentences, pull-quote lines,
 and objects that want, take, or write things.

**Semantic line breaks.**
Start each sentence on its own line.
Wrap a long sentence at a clause boundary
 and indent each continuation by one space.

Tables and source blocks are unchanged.
A list item's first sentence starts after the bullet;
 a later sentence in that item aligns with the first;
 a wrap of the same sentence is one extra space.

**Sentence length.**
Mix short sentences with longer ones in a paragraph.
Join related facts instead of stacking five declarations of similar length;
 a staccato of short sentences spoils the writing.

**Explain.**
State what something is, or what to do.
Delete a sentence that would work as a slide caption.
Drop a line that only restates the heading.
Tables may stay telegraphic; body prose should not.

**Subjects.**
The subject is a person, a program, or an instruction
 (`put`, `set`, `keep`, `omit`, `use`).
Do not anthropomorphize things:
 directories, trees, and files do not want, take, write, or care.

**Contrast.**
Lead with the fact.
A “this is X, not Y” opening is usually filler;
 use a contrast only when the distinction is the content.

### Comment style

Comments document the **interface** of the thing they sit on
 (function, type, field, module): what callers need to know,
 how it relates to other types in this repo, and when to use it.

Start each new sentence on its own comment line.
Wrap a long sentence with a two-space hanging indent:

```rust
    /// The keyboard frontend manages the path from the hardware matrix
    ///  through to press/release events on the layout.
```

Use names that exist in the tree: types, fields, modules, paths, rustdoc.
Referring to resources outside the repo
 (chat transcripts, review threads, local-only files)
 is unhelpful.
