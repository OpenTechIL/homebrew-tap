# Homebrew formula for agentry.
#
# Intended for a tap (e.g. `OpenTechIL/homebrew-tap`): `brew install OpenTechIL/tap/agentry`.
# `version` and the per-asset `sha256` values are release-specific — release automation
# fills them from SHA256SUMS.txt (see packaging/README.md). The 64-zero shas below are
# placeholders so the structure is reviewable before the first tagged release.
class Agentry < Formula
  desc "Dependency manager for AI coding agents"
  homepage "https://github.com/OpenTechIL/agentry"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/OpenTechIL/agentry/releases/download/v#{version}/agentry-#{version}-macos-arm64"
      sha256 "b69692575a4be7bfa7bf2530cc6d34d2600f1ee1e1f1c89ee9cdb4ca0fa7d93a"
    end
    on_intel do
      url "https://github.com/OpenTechIL/agentry/releases/download/v#{version}/agentry-#{version}-macos-x86_64"
      sha256 "5c906fbaa1eae51c8c2c7242ad5fbc88309d20ef9a962da4653b03a0d4ae889e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/OpenTechIL/agentry/releases/download/v#{version}/agentry-#{version}-linux-x86_64"
      sha256 "1b903e95a0f849b3f8249fa10f92e9317286afafe1fae8ae6711f474163a3de2"
    end
    # linux-arm64 has no prebuilt binary yet (see install.sh); use `uv tool install`.
  end

  def install
    # The release asset is the bare binary, named agentry-<version>-<target>.
    bin.install Dir["agentry-*"].first => "agentry"
    # Short aliases. `agy` is kept for back-compat, but Google's Antigravity CLI also
    # claims that name — `agyx` is the short name that cannot collide. Homebrew prints its
    # own caveat when a linked binary is shadowed on PATH.
    bin.install_symlink bin/"agentry" => "agy"
    bin.install_symlink bin/"agentry" => "agyx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agentry version")
  end
end
