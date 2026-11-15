# Homebrew formula for agentry.
#
# Intended for a tap (e.g. `OpenTechIL/homebrew-tap`): `brew install OpenTechIL/tap/agentry`.
# `version` and the per-asset `sha256` values are release-specific — release automation
# fills them from SHA256SUMS.txt (see packaging/README.md). The 64-zero shas below are
# placeholders so the structure is reviewable before the first tagged release.
class Agentry < Formula
  desc "Dependency manager for AI coding agents"
  homepage "https://github.com/OpenTechIL/agentry"
  version "0.3.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/OpenTechIL/agentry/releases/download/v#{version}/agentry-#{version}-macos-arm64"
      sha256 "886fe2593a3b3efad181ad708ff9ca641607fc2f212844ccbfea1e82984f128f"
    end
    on_intel do
      url "https://github.com/OpenTechIL/agentry/releases/download/v#{version}/agentry-#{version}-macos-x86_64"
      sha256 "16bd65040d3482ad4b600b618ab3424805bcdc2c3a2850117576aba164917dd7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/OpenTechIL/agentry/releases/download/v#{version}/agentry-#{version}-linux-x86_64"
      sha256 "a6f58b7fdb86bfe0672190b4ff739e01d1a9cd5c8fecf812f6357a99362a5755"
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
