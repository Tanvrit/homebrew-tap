# Tanvrit Homebrew Tap

Homebrew tap for Tanvrit command-line tools.

```sh
brew tap tanvrit/tap
brew install tanvrit
tanvrit status --json
```

Or in one shot:

```sh
brew install tanvrit/tap/tanvrit
```

## Formulae

| Formula | Installs | Downloads from |
|---|---|---|
| `tanvrit` | The Tanvrit AI CLI (`tanvrit`) | `dl.tanvrit.com` |

The `tanvrit` CLI is a self-contained runtime image with a bundled JRE — no
separate Java install is needed. It reaches the same functionality as the
Tanvrit AI desktop app. See https://github.com/Tanvrit/ai-releases and
https://ai.tanvrit.com.

## How versions are kept current

`Formula/tanvrit.rb`'s version and per-platform `sha256` values are updated
automatically by the app repo's release pipeline each time a new version is
published, so `brew upgrade tanvrit` tracks releases without manual edits.

## License

MIT © Tanvrit Private Limited.
