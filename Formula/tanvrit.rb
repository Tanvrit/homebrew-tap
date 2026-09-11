# Tanvrit AI CLI — Homebrew formula.
#
# The CLI ships as a self-contained jlink runtime image (a bundled JRE plus the
# app jars), NOT a single executable — so this installs the extracted tree into
# libexec and shims the launcher into bin, rather than dropping one binary.
#
# The sha256 values are pinned automatically at release time by the app repo's
# release workflow (see .github/workflows/bump-formula.yml here): it downloads
# each freshly published tarball, computes its sha256, rewrites this file, and
# pushes. Until the first release runs that automation the REPLACE_ON_RELEASE_*
# placeholders make `brew install` fail loudly rather than install wrong bytes.
class Tanvrit < Formula
  desc "Tanvrit AI CLI — local coding agent, MCP server, and repo grounding"
  homepage "https://ai.tanvrit.com"
  version "1.5.32"
  license "MIT"

  on_macos do
    on_arm do
      url "https://dl.tanvrit.com/ai/manual/tanvrit-cli-#{version}-macOS-arm64.tar.gz"
      sha256 "REPLACE_ON_RELEASE_MACOS_ARM64"
    end
    on_intel do
      url "https://dl.tanvrit.com/ai/manual/tanvrit-cli-#{version}-macOS-x64.tar.gz"
      sha256 "REPLACE_ON_RELEASE_MACOS_X64"
    end
  end

  on_linux do
    on_arm do
      url "https://dl.tanvrit.com/ai/manual/tanvrit-cli-#{version}-Linux-arm64.tar.gz"
      sha256 "REPLACE_ON_RELEASE_LINUX_ARM64"
    end
    on_intel do
      url "https://dl.tanvrit.com/ai/manual/tanvrit-cli-#{version}-Linux-x64.tar.gz"
      sha256 "REPLACE_ON_RELEASE_LINUX_X64"
    end
  end

  def install
    # The tarball extracts to a single top-level dir which Homebrew strips, so
    # the contents (bin/, lib/, runtime/) land in the staging root.
    libexec.install Dir["*"]
    # write_env_script execs the real launcher, so its APP_HOME/dirname logic
    # resolves against libexec and finds the bundled runtime.
    (bin/"tanvrit").write_env_script libexec/"bin/tanvrit", {}
  end

  test do
    # status runs fully in-process with no app, no engine and no network, and
    # prints one JSON envelope naming the backend — a real end-to-end check.
    assert_match "\"backend\"", shell_output("#{bin}/tanvrit status --json")
  end
end
